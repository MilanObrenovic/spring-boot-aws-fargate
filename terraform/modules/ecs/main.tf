# ECS cluster
resource "aws_ecs_cluster" "notes_ecs_cluster" {
	name = "notes-api-dev-cluster"

	tags = {
		Name        = "${var.environment}-ecs-cluster"
		Environment = var.environment
	}
}

# Task definition
resource "aws_ecs_task_definition" "notes_ecs_task_definition" {
	family = "notes-api-task-definition"

	container_definitions = jsonencode([
		{
			name         = "notes-api-container"
			image        = "${var.ecr_image_uri}:latest"
			cpu          = 10
			memory       = 512
			essential    = true
			portMappings = [
				{
					containerPort = 8080
					hostPort      = 8080
				}
			],
			environment = [
				{
					name  = "AWS_RDS_DATABASE_HOST",
					value = var.rds_database_host_name
				},
				{
					name  = "AWS_RDS_DATABASE",
					value = "notes_db"
				},
				{
					name  = "AWS_RDS_DATABASE_USERNAME",
					value = "postgres"
				},
				{
					name  = "AWS_RDS_DATABASE_PASSWORD",
					value = "password"
				}
			]
		}
	])
}
