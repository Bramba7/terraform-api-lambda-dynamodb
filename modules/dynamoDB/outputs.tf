output "table_arn" {
  description = "DynamoDB table ARN"
  value = aws_dynamodb_table.this.arn
}
