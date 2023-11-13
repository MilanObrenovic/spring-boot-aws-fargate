variable "environment" {
	type        = string
	description = "Environment name."
}

variable "ecr_image_uri" {
	type = string
	description = "URI of the image from ECR."
}

variable "rds_database_host_name" {
	type = string
	description = "RDS database host name."
}

variable "public_subnets_cidr" {
	type = list(string)
	description = "Public VPC subnets."
}

variable "private_subnets_cidr" {
	type = list(string)
	description = "Private VPC subnets."
}

variable "notes_fargate_security_group_id" {
	type = string
	description = "Fargate security group."
}

variable "notes_lb_security_group_id" {
	type = string
	description = "Load Balancer security group."
}

variable "vpc_id" {
	type = string
	description = "ID of the VPC to use."
}
