variable "load_balancer_name" {
  description = "Name for the load balancer"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs for the load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS listener"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
}

