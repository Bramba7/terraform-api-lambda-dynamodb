variable "environment" {
  description = "The name of the environment"
}
variable "vpc" {
  description = "VPC id"
}
variable "subnet"{
  description = "Simple public subnet"
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
