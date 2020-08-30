
# Create vpc
resource "aws_vpc" "myapp_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = var.vpc_tenancy
    tags = var.vpc_tags
}

# create public subnets
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.myapp_vpc.id
  cidr_block = var.subnet_cidrs
  tags = var.public_sub_tags
  
}
