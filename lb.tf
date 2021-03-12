  data "aws_subnet_ids" "and_project" {
  vpc_id = aws_vpc.and_vpc.id

  tags = {
    Tier = "and_project"
  }
      depends_on = [aws_subnet.public-subnet-1, aws_subnet.public-subnet-2]
}
