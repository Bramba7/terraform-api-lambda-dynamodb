resource "aws_lambda_function" "get" {
  filename         = "GET.zip"
  function_name    = "${var.environment}getData"
  role             = var.aws_iam_arn
  memory_size      = var.memory_size
  handler          = "index.handler"
  timeout          = var.timeout_lambda
  source_code_hash = filebase64sha256("GET.zip")
  runtime          = "nodejs12.x"
  vpc_config {
    subnet_ids         = [var.private_subnet1, var.private_subnet2]
    security_group_ids = [var.sg]
  }
}

resource "aws_lambda_function" "put" {
  filename         = "PUT.zip"
  function_name    = "${var.environment}putData"
  memory_size      = var.memory_size
  role             = var.aws_iam_arn
  handler          = "index.handler"
  timeout         = var.timeout_lambda
  source_code_hash = filebase64sha256("PUT.zip")
  runtime          = "nodejs12.x"

  vpc_config {
    subnet_ids         = [var.private_subnet1, var.private_subnet2]
    security_group_ids = [var.sg]
  }
}
