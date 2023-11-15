variable "environment" {
	type        = string
	description = "Environment name."
}

variable "private_subnets_cidr" {
	type        = list(string)
	description = "CIDR block for Private Subnets."
}

variable "rds_subnet_group_name" {
	type        = string
	description = "Name of the RDS Subnet Group."
}

variable "vpc_id" {
	type        = string
	description = "VPC ID for Security Group."
}

variable "rds_security_group_id" {
	type        = string
	description = "RDS Security Group ID."
}

variable "rds_database_name" {
	type        = string
	description = "RDS database name."
}

variable "rds_database_username" {
	type        = string
	description = "RDS database username."
}

variable "rds_database_password" {
	type        = string
	description = "RDS database password."
}
