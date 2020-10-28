output "aws_iam_arn" {
  description = "ARN of IAM role"
  value = aws_iam_role.lambda_DynamoDB_Role.arn
}
