# variables.tf

variable "cluster_id" {
  description = "The ECS cluster ID"
  type        = string
}

variable "task_definition_arn" {
  description = "The ARN of the task definition"
  type        = string
}

variable "container_port" {
  description = "The port of the ECS container"
  type        = number
}

variable "target_group_arn" {
  description = "The ARN of the target group"
  type        = string
}

variable "security_groups" {
  description = "The security groups associated with the ECS service"
  type        = list(string)
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "subnets" {
  description = "The subnets for the ECS service"
  type        = list(string)
}

variable "min_capacity" {
  description = "Minimum number of tasks"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of tasks"
  type        = number
}

variable "cpu_policy_name" {
  description = "The name of the CPU scaling policy"
  type        = string
}

variable "cpu_target_value" {
  description = "Target CPU utilization percentage"
  type        = number
}

variable "scale_in_cooldown" {
  description = "Cooldown period after scaling in (in seconds)"
  type        = number
}

variable "scale_out_cooldown" {
  description = "Cooldown period after scaling out (in seconds)"
  type        = number
}

variable "disable_scale_in" {
  description = "Whether to disable scaling in"
  type        = bool
}

