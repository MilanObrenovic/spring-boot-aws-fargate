variable "aws_region" {
	type        = string
	default     = "eu-central-1"
	description = "Default AWS region."
}

variable "environment" {
	type        = string
	default     = "terraform-aws"
	description = "Environment name."
}

variable "vpc_cidr" {
	type        = string
	default     = "10.0.0.0/16"
	description = "CIDR block of the VPC."
}

variable "public_subnets_cidr" {
	type        = list(any)
	default     = ["10.0.0.0/20", "10.0.128.0/20"]
	description = "CIDR block for Public Subnet."
}

variable "private_subnets_cidr" {
	type        = list(any)
	default     = ["10.0.16.0/20", "10.0.144.0/20"]
	description = "CIDR block for Private Subnet."
}
