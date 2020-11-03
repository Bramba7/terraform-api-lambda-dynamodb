
resource "aws_dynamodb_table" "this" {
  name           = var.dynamodb_table_name
  billing_mode   = var.billing
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Environment = var.environment
  }
}

#seed item 
resource "aws_dynamodb_table_item" "this" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = aws_dynamodb_table.this.hash_key

  item = <<ITEM
{
  "id": {"S": "1"},
  "firstName": {"S": "John "},
  "lastName": {"S": "Smith"}
   }
ITEM
}
