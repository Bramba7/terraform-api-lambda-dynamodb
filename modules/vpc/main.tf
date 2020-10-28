resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "VPC_${var.environment}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "IGW_${var.environment}"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.sub_cidr
  availability_zone = "us-west-2a"   #redo

  tags = {
    Name = "Subnet 1_${var.environment}"
  }
}


resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rtb.id
}


# resource "aws_network_acl" "allowall" {    
#   vpc_id = aws_vpc.vpc.id

#   egress {
#     protocol = "-1" #all protocols (tcp/udp etc)
#     rule_no = 100 #where it is in the stack
#     action = "allow" #allows all 
#     cidr_block = "0.0.0.0/0"
#     from_port = 0 #from all port ranges
#     to_port = 0 #to all port ranges

#   }
#   ingress {
#     from_port = 0 #from all port ranges 
#     to_port = 0 #to all port rangers
#     protocol = "-1"
#     action = "allow" #allows all
#     rule_no = 200 #where it is in the stack
#     cidr_block = "0.0.0.0/0" #
#   } 
# }


resource "aws_security_group" "sg_for_lambda" { #redo
  name        = "sg_for_lambda"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_for_lambda"
  }
}