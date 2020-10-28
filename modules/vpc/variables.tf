variable "vpc_cidr" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
}
variable "sub_cidr" {
  description = "subnet cidr block. Example: 10.0.0.0/24"
}
variable "environment" {
  description = "The name of the environment"
}
