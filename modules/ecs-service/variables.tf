variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "launch_type" {
  description = "Launch type for the ECS service"
  type        = string
  default     = "FARGATE"
}

variable "platform_version" {
  description = "Platform version for the ECS service"
  type        = string
  default     = "LATEST"
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "task_definition_arn" {
  description = "The ARN of the ECS task definition"
  type        = string
}

variable "scheduling_strategy" {
  description = "The scheduling strategy for the service"
  type        = string
  default     = "REPLICA"
}

variable "desired_count" {
  description = "The number of instantiations of the task definition to place and keep running"
  type        = number
  default     = 2
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit on the number of running tasks during a deployment"
  type        = number
  default     = 100
}

variable "deployment_maximum_percent" {
  description = "The upper limit on the number of running tasks during a deployment"
  type        = number
  default     = 200
}

variable "target_group_arn" {
  description = "The ARN of the target group"
  type        = string
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "container_port" {
  description = "The port on the container to associate with the target group"
  type        = number
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP address to the task"
  type        = bool
  default     = true
}

variable "security_groups" {
  description = "A list of security group IDs to associate with the task"
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnet IDs for the task"
  type        = list(string)
}

