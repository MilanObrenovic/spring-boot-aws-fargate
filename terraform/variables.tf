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
	type        = list(string)
	description = "CIDR block for Public Subnets."
}

variable "private_subnets_cidr" {
	type        = list(string)
	description = "CIDR block for Private Subnets."
}

variable "ecr_repository_name" {
	type        = string
	description = "Repository name of the ECR."
}

variable "rds_subnet_group_name" {
	type        = string
	description = "Name of the RDS Subnet Group."
}

variable "acm_certificate_domain_name" {
	type        = string
	description = "Route53 domain name to which this certificate is gonna be applied."
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

variable "route53_zone_name" {
	type        = string
	description = "Domain name (such as example.com)."
}

variable "route53_api_subdomain_name" {
	type        = string
	description = "Subdomain name of the backend API."
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
