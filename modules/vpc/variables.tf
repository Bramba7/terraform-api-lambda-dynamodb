variable "vpc_cidr" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
}
variable "public1_sub_cidr" {
  description = "subnet cidr block. Example: 10.0.0.0/24"
}
variable "public2_sub_cidr" {
  description = "subnet cidr block. Example: 10.0.0.0/24"
}
variable "private1_sub_cidr" {
  description = "subnet cidr block. Example: 10.0.0.0/24"
}
variable "private2_sub_cidr" {
  description = "subnet cidr block. Example: 10.0.0.0/24"
}

variable "environment" {
  description = "The name of the environment"
}
variable "aws_region"{
    description = "The Amazon Region"
 }