resource "aws_lambda_function" "get" {
  filename         = "lambdaget.zip"
  function_name    = "${var.environment}_get_user_data"
  role             = var.aws_iam_arn
  memory_size      = "128"
  handler          = "index.handler"
  timeout          = var.timeout_lambda
  source_code_hash = filebase64sha256("lambdaget.zip")

  runtime          = "nodejs12.x"

  vpc_config {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids         = [var.subnet]
    security_group_ids = [var.sg]
  }

  # environment {
  #   variables = {foo = "bar"}
  # }
  
}

resource "aws_lambda_function" "post" {
  filename      = "lambdapost.zip"
  function_name = "${var.environment}_post_user_data"
  memory_size   = "128"
  role          = var.aws_iam_arn
  handler       = "index.handler"
  timeout       = var.timeout_lambda

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("lambdapost.zip")

  runtime = "nodejs12.x"

   vpc_config {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids         = [var.subnet]
    security_group_ids = [var.sg]
  }


  # environment {
  #   variables = {
  #     foo = "bar"
  #   }
  # }
}
