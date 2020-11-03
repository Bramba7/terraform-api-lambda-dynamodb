output "vpc" {
  value = aws_vpc.vpc.id
}
output "public_subnet1"{
  value = aws_subnet.public_subnet1.id
}
output "private_subnet1"{
  value = aws_subnet.private_subnet1.id
}
output "private_subnet2"{
  value = aws_subnet.private_subnet2.id
}
output "sg"{
  value = aws_security_group.sg_for_lambda.id
}

output "igw" {
  value = aws_internet_gateway.igw.id
}
