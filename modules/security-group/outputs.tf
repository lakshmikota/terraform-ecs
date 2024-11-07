output "alb_security_group_id" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.alb_security_group.id
}

output "ecs_security_group_id" {
  description = "The ID of the ECS security group"
  value       = aws_security_group.ecs_security_group.id
}

