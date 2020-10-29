resource "aws_iam_role" "lambda_DynamoDB_Role" {
  name = "${var.environment}_lambda_DynamoDB_Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      } ,
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
#Aws Basic Execution Role
resource "aws_iam_role_policy_attachment" "basic-exec-role" {
    role       = aws_iam_role.lambda_DynamoDB_Role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "vpc_access" {
    role       = aws_iam_role.lambda_DynamoDB_Role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
# POLICIES
resource "aws_iam_role_policy" "lambda_DynamoDB_Policy"{
  name = "${var.environment}_lambda_DynamoDB_Policy"
  role = aws_iam_role.lambda_DynamoDB_Role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem"
      ],
      "Resource": "${var.table_arn}"
    }
  ]
}
EOF
}

