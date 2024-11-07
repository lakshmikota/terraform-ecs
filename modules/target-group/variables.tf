variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "port" {
  description = "The port on which the target group receives traffic"
  type        = number
}

variable "protocol" {
  description = "The protocol used by the target group"
  type        = string
}

variable "target_type" {
  description = "The type of target (e.g., ip, instance)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

