provider "aws" {
  region = var.my_region
  access_key = var.access_key  # aws access key
  secret_key = var.secret_key  # aws secret key
}

resource "aws_instance" "instance_1" {
  ami = var.ami
  instance_type = "t2.micro"
  key_name = "and_project_instance_1"
  associate_public_ip_address = true
  subnet_id = aws_subnet.public-subnet-1.id
  vpc_security_group_ids = aws_security_group.app_security_group.id
  tags = {
    Name = "instance_1"
  }
}

resource "aws_instance" "instance_2" {
  ami = var.ami
  instance_type = "t2.micro"
  key_name = "and_project_instance_2"
  associate_public_ip_address = true
  subnet_id = aws_subnet.public-subnet-2.id
  vpc_security_group_ids = aws_security_group.app_security_group.id
  tags = {
    Name = "instance_2"
  }
}