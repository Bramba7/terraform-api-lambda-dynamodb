provider "aws" { 
  shared_credentials_file = "~/.aws/credentials"
  region = var.aws_region
}

terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    shared_credentials_file = "~/.aws/credentials"
    bucket = "bramba-bucket"
    key    = "terraform/terraform.tfstate"
    region = "us-west-2"
    acl = "private"
    encrypt = true 
  }
}

module "vpc" {
    source = "./modules/vpc"
    environment = var.environment
    cidr = var.vpc_cidr
}

module "dynamoDB" {
    source = "./modules/dynamoDB"
    region = var.aws_region
    environment = var.environment
    billing = var.billing
    write_capacity = var.write_capacity
    read_capacity = var.read_capacity
    dynamodb_table_name = var.dynamodb_table_name
}
module "iamRole" {
    source = "./modules/iamRole"
    environment = var.environment
    table_arn = module.dynamoDB.table_arn
 }
#  module "lambda" {
#     source = "./modules/lambda"
#     environment = var.environment
#     timeout_lambda = var.timeout_lambda
#     aws_iam_arn = module.iamRole.aws_iam_arn
#  }


variable "environment" {}
variable "vpc_cidr" {}
variable "aws_region" {}
variable "dynamodb_table_name" {}
variable "billing" {} 
variable "write_capacity"{} 
variable "read_capacity" {} 
variable "timeout_lambda"{}