
provider "aws" {
  region = "us-east-2"
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  default = "10.0.10.0/24"
  type = string
}

variable "cidr_blocks" {
  description = "cidr blocks and name tags for vpc and subnets"
  type = list(object({
    cidr_block = string
    name = string
    }))
}

#variable "vpc_cidr_block" {
#  description = "vpc cidr block"
#}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
    Name: var.cidr_blocks[0].name
  }
}
#10.0.0.0/16

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = "us-east-2b"
  tags = {
    Name: var.cidr_blocks[1].name
  }
}
#10.0.10.0/24

#output "dev-vpc-id" {
#  value = aws_vpc.development-vpc.id
#}

#output "dev-subnet-id" {
#  value = aws_subnet.dev-subnet-1.id
#}





#data returns something that already exists (in this case, the default VPC)
#data "aws_vpc" "existing_vpc" {
#  default = true
#}

#when refrencing data, use data. prefix to reference it
#resource "aws_subnet" "dev-subnet-2" {
#  vpc_id = data.aws_vpc.existing_vpc.id
#  cidr_block = "172.31.48.0/20"
#  availability_zone = "us-east-2b"
#  tags = {
#    Name: "subnet-2-default"
#  }
#}
