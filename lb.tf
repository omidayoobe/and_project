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

  resource "aws_lb_target_group" "lb_target_group_and_project" {

    port        = 80
    protocol    = "TCP"
    target_type = "instance"
    vpc_id      = aws_vpc.and_vpc.id

    health_check {
      healthy_threshold   = 2
      interval            = 30
      protocol            = "HTTP"
      unhealthy_threshold = 2
    }

    depends_on = [
      aws_lb.lb_and_project
    ]

    lifecycle {
      create_before_destroy = true
    }
  }

  resource "aws_lb_listener" "and_project_lb_listener" {

    load_balancer_arn = aws_lb.lb_and_project.arn

    protocol          = "TCP"
    port              = 80

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.lb_target_group_and_project.arn
    }
  }