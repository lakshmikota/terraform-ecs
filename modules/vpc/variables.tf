variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet1_cidr" {
  description = "CIDR block for Subnet 1"
  type        = string
}

variable "subnet2_cidr" {
  description = "CIDR block for Subnet 2"
  type        = string
}

variable "az1" {
  description = "Availability Zone for Subnet 1"
  type        = string
}

variable "az2" {
  description = "Availability Zone for Subnet 2"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "environment" {
  description = "The environment (dev, prod, etc.)"
  type        = string
}

