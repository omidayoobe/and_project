provider "aws" {
  region = var.my_region
  access_key = var.access_key  # aws access key
  secret_key = var.secret_key  # aws secret key
}

resource "aws_instance" "instance_1" {
  ami = var.ami
  instance_type = "t2.micro"

  tags = {
    Name = "instance_2"
  }
}

resource "aws_instance" "instance_2" {
  ami = var.ami
  instance_type = "t2.micro"

  tags = {
    Name = "instance_2"
  }
}