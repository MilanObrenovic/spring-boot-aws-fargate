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

variable "notes_lb_sg_name" {
	type        = string
	description = "Security Group name for the Load Balancer."
}

variable "notes_fargate_sg_name" {
	type        = string
	description = "Security Group name for the Fargate API deployment."
}

variable "notes_rds_sg_name" {
	type        = string
	description = "Security Group name for the RDS database."
}
