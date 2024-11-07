# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Subnet 1
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az1

  tags = {
    Name = "${var.environment}-subnet1"
  }
}

# Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az2

  tags = {
    Name = "${var.environment}-subnet2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-internet-gateway"
  }
}

# Route Table
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }

  tags = {
    Name = "${var.environment}-route-table"
  }
}

# Route Table Association for Subnet 1
resource "aws_route_table_association" "RTA1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.RT.id
}

# Route Table Association for Subnet 2
resource "aws_route_table_association" "RTA2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.RT.id
}

