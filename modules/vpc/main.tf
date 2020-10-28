resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "VPC_${var.environment}"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "vpc" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "IGW_${var.environment}"
    Environment = var.environment
  }
}
