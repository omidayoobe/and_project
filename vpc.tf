resource "aws_vpc" "and_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags ={
    Name = "and_vpc"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.and_vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.and_vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "eu-west-1b"
  tags = {
    Name = "public-subnet-2"
  }
}