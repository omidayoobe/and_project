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

resource "aws_internet_gateway" "internet_access" {
  vpc_id = aws_vpc.and_vpc.id
  tags = {
    Name = "and_project_internet_gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.and_vpc.id
  route {
    cidr_block = "0.0.0.0/0" #any traffic should go through gate way
    gateway_id = aws_internet_gateway.internet_access.id
  }
  tags = {
    Name = "route_tb_and_project"
  }
}

resource "aws_route_table_association" "associate_route_table_1" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "associate_route_table_2" {
  subnet_id = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_network_acl" "acl_public_sub" {
  vpc_id = aws_vpc.and_vpc.id
  subnet_ids = [aws_subnet.public-subnet-1.id,aws_subnet.public-subnet-2.id]

  ingress {
    protocol   = "-1"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "acl_public_sub"
  }
}
