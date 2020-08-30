# Declare variables

variable "vpc_cidr" {
  description = "Choose cidr for VPC"
  type = "string"
  default = "10.0.0.0/16"
}

variable "vpc_tenancy" {
  description = "Choose vpc tenancy"
  type = "string"
  default = "default"
}

variable "vpc_tags" {
  type = "map"
  default = {
    Name = "Terraform-vpc"
    City = "Bangalore"
    Location = "USA"
  }
}

# tags for public subnet_cidrs
variable "public_sub_tags" {
  type = "map"
  default = {
    Name = "public_subnet"
  }
}

variable "subnet_cidrs" {
  description = "Choose cidr for public_subnet"
  type = "string"
  default = "10.0.0.0/16"
}
