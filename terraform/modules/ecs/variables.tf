variable "environment" {
	type        = string
	description = "Environment name."
}

variable "ecr_image_uri" {
	type        = string
	description = "URI of the image from ECR."
}

variable "rds_database_host_name" {
	type        = string
	description = "RDS database host name."
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

variable "public_subnets_cidr" {
	type        = list(string)
	description = "Public VPC subnets."
}

variable "private_subnets_cidr" {
	type        = list(string)
	description = "Private VPC subnets."
}

variable "notes_fargate_security_group_id" {
	type        = string
	description = "Fargate security group."
}

variable "notes_lb_security_group_id" {
	type        = string
	description = "Load Balancer security group."
}

variable "vpc_id" {
	type        = string
	description = "ID of the VPC to use."
}

variable "notes_api_dev_cluster_name" {
	type        = string
	description = "Name of the development ECS cluster."
}

variable "notes_api_task_definition_name" {
	type        = string
	description = "Name of the task definition."
}

variable "notes_api_container_name" {
	type        = string
	description = "Name of the task definition's container."
}

variable "notes_api_container_name_port_mappings" {
	type        = string
	description = "Name of the port mappings for the container."
}

variable "notes_api_ecs_lb_name" {
	type        = string
	description = "Name of the ECS Load Balancer."
}

variable "notes_api_ecs_tg_name" {
	type        = string
	description = "Name of the ECS Target Group (TG)."
}

variable "notes_api_service_name" {
	type        = string
	description = "Name of the ECS service."
}
