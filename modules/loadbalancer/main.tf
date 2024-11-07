# Create application load balancer
resource "aws_lb" "application_load_balancer" {
  name               = "${var.load_balancer_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
  enable_deletion_protection = false

  tags = {
    Name = "${var.load_balancer_name}"
  }
}

# Create HTTP listener for port 80 with redirect action
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Create HTTPS listener for port 443 with forward action
resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}

