variable "alb_sg_name" {
  description = "The name of the ALB security group"
  type        = string
}

variable "ecs_sg_name" {
  description = "The name of the ECS security group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to associate the security groups with"
  type        = string
}

