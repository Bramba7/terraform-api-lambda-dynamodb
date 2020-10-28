output "vpc" {
  value = aws_vpc.vpc.id
}
output "subnet"{
  value = aws_subnet.public_subnet1.id
}

output "sg"{
  value = aws_security_group.sg_for_lambda.id
}

output "igw" {
  value = aws_internet_gateway.igw.id
}
