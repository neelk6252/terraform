resource "aws_lb_target_group" "main" {
  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTPS"
    timeout             = 10
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
  name        = var.ALB-TG-Name
  port        = 8501
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "instance"
  tags = {
    Name = "Transbnk-TG"
  }
}




resource "aws_lb" "ALB" {
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [var.security-groups]
  subnets            = var.subnetsids
  tags = {
    Name = "Transbnk-ALB"
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }
}




output "alb_target_group_arn" {
  value = aws_lb_target_group.main.arn
}