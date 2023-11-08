variable "aws_region" {
  type        = string
  description = "Default AWS region."
}

variable "environment" {
  type        = string
  description = "Environment name."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block range of the VPC."
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet."
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet."
}
