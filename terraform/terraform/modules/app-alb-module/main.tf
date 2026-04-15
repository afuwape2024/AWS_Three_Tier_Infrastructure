#create the targer group 
resource "aws_lb_target_group" "internal_target_group" {
  name        = "internal-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.new_vpc
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "internal_listener" {
  load_balancer_arn = aws_lb.internal_application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_target_group.arn
  }
}


#application load balancer for private subnet

resource "aws_security_group" "internal_application_load_balancer_sg" {
  name   = "internal-alb-sg"
  vpc_id = var.new_vpc

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.load_balancer_security_group]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_lb" "internal_application_lb" {
  name               = "app-internal-application-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_application_load_balancer_sg.id]
  subnets            = var.app_subnet_ids
}

