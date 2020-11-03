resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "VPC_${var.environment}"
  }
}

#### GateWays
resource "aws_eip" "eip" {
   depends_on    = [aws_internet_gateway.igw]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "IGW_${var.environment}"
  }
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet1.id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name        = "NGW_${var.environment}"
  }
}

#### Subnets
resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public1_sub_cidr
  availability_zone = "${var.aws_region}a"  

  tags = {
    Name = "Public_Subnet_1_${var.environment}"
  }
}
resource "aws_subnet" "public_subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public2_sub_cidr
  availability_zone = "${var.aws_region}b"  

  tags = {
    Name = "Public_Subnet_1_${var.environment}"
  }
}
resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private1_sub_cidr
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "Private_Subnet_1_${var.environment}"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private2_sub_cidr
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "Private_Subnet_2_${var.environment}"
  }
}

### Tables
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name        = "rtb_public_${var.environment}"
  }
}

resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name        = "rtb_private_${var.environment}"
  }
}

resource "aws_route_table_association" "rtba_public1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rtb_public.id
}
resource "aws_route_table_association" "rtba_public2" {
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.rtb_public.id
}
resource "aws_route_table_association" "rtba_private1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.rtb_private.id
}

resource "aws_route_table_association" "rtba_private2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.rtb_private.id
}


### Security Grups

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