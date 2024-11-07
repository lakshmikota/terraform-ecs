# Security Group for Application Load Balancer
resource "aws_security_group" "alb_security_group" {
  name        = var.alb_sg_name
  description = "Allow HTTP/HTTPS access on ports 80/443"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.alb_sg_name
  }
}

# Security Group for ECS Container
resource "aws_security_group" "ecs_security_group" {
  name        = var.ecs_sg_name
  description = "Allow HTTP/HTTPS access via ALB security group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP access from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description      = "HTTPS access from ALB"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ecs_sg_name
  }
}

