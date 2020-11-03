variable "environment" {
  description = "The name of the environment"
}
variable "vpc" {
  description = "VPC id"
}
variable "private_subnet1"{
  description = "Simple private subnet"
}
variable "private_subnet2"{
  description = "Simple private subnet"
}
variable "sg"{
  description = "security group that allow all"
}
variable "aws_iam_arn" {
  description = "ARN of IAM role"
}
variable "timeout_lambda" {
  description = "timeout of lambda"
}

variable "memory_size" {
  description = "Memory size of lambda"
}