  data "aws_subnet_ids" "and_project" {
  vpc_id = aws_vpc.and_vpc.id

  tags = {
    Tier = "and_project"
  }
      depends_on = [aws_subnet.public-subnet-1, aws_subnet.public-subnet-2]
}


  resource "aws_lb" "lb_and_project" {
    name               = "and-load-balancer"
    load_balancer_type = "application"
    subnets            = data.aws_subnet_ids.and_project.ids
    security_groups = [aws_security_group.app_security_group.id]

    enable_cross_zone_load_balancing = true
  } 