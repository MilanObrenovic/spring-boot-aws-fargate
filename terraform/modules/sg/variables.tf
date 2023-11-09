variable "environment" {
	type        = string
	description = "Environment name."
}

variable "vpc_id" {
	type        = string
	description = "VPC ID for Security Group."
}

variable "vpc_cidr_block" {
	type        = string
	description = "CIDR block from the VPC."
}
