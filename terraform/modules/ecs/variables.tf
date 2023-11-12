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

variable "aws_iam_role_ecs_task_execution_arn" {
	type = string
	description = "IAM role ARN that can execute ECS task."
}
