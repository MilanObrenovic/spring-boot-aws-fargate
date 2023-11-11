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
