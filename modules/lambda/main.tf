resource "aws_lambda_function" "get" {
  filename         = "GET.zip"
  function_name    = "${var.environment}getData"
  role             = var.aws_iam_arn
  memory_size      = "128"
  handler          = "index.handler"
  timeout          = var.timeout_lambda
  source_code_hash = filebase64sha256("GET.zip")
  runtime          = "nodejs12.x"

  # vpc_config {
  #   # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
  #   subnet_ids         = [var.subnet]
  #   security_group_ids = [var.sg]
  # }
  
}

resource "aws_lambda_function" "put" {
  filename         = "PUT.zip"
  function_name    = "${var.environment}putData"
  memory_size      = "128"
  role             = var.aws_iam_arn
  handler          = "index.handler"
  timeout         = var.timeout_lambda
  source_code_hash = filebase64sha256("PUT.zip")
  runtime          = "nodejs12.x"

  #  vpc_config {
  #   # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
  #   subnet_ids         = [var.subnet]
  #   security_group_ids = [var.sg]
  # }


}
