resource "aws_lambda_function" "get_user_data" {
  #filename = "${path.module}/get.zip"
  function_name = "get_user_data"
  role = "var.aws_iam_arn"
  memory_size = "128"
  #handler = "lambda_getRaceResults.main"

  #source_code_hash = filebase64sha256("${path.module}/get.zip")

  runtime = "nodejs12.x"

  # in seconds
  timeout = var.timeout_lambda

}


resource "aws_lambda_function" "put_user_data" {
  #filename = "${path.module}/put.zip"
  function_name = "push_user_data"
  role = "var.aws_iam_arn"
  #handler = "lambda_getRaceResults.main"

  #source_code_hash = filebase64sha256("${path.module}/get.zip")

  runtime = "nodejs12.x"

  # in seconds
  timeout = var.timeout_lambda

}
