
locals {
  azs = data.aws_availability_zones.azs.names
}

# Create vpc
resource "aws_vpc" "myapp_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = var.vpc_tenancy
    tags = var.vpc_tags
}

# create public subnets
resource "aws_subnet" "main" {
  count = length(local.azs)
  vpc_id     = aws_vpc.myapp_vpc.id
  cidr_block = element(var.subnet_cidrs, count.index)
  availability_zone = element(local.azs, count.index)
  tags = var.public_sub_tags
}

# create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myapp_vpc.id
  tags = {
    Name = "terraform_igw"
  }
}

# create custom route table for public subnets
resource "aws_route_table" "r" {
  vpc_id = aws_vpc.myapp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "terraform_public_routetable"
  }
}

# create associate piblic subnets with public route table
resource "aws_route_table_association" "a" {
  count = length(local.azs)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = aws_route_table.r.id
}
