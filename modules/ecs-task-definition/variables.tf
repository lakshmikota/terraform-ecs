variable "family" {
  description = "The family of the ECS task definition"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that the ECS task should use for execution"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the IAM role that the ECS task should use for its operations"
  type        = string
}

variable "cpu" {
  description = "The number of CPU units for the task"
  type        = number
}

variable "memory" {
  description = "The amount of memory (in MiB) for the task"
  type        = number
}

variable "container_definitions" {
  description = "The container definitions for the task"
  type = list(object({
    name             = string
    image            = string
    cpu              = number
    memory           = number
    essential        = bool
    portMappings     = list(object({
      containerPort  = number
      hostPort       = number
    }))
    logConfiguration = object({
      logDriver = string
      options   = map(string)
    })
  }))
}

