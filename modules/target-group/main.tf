resource "aws_lb_target_group" "TG" {
  name        = var.target_group_name
  port        = var.port
  protocol    = var.protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = var.target_group_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

