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
	# Task definition configuration
	family = "notes-api-task-definition"

	# Infrastructure requirements
	requires_compatibilities = ["FARGATE"]
	network_mode             = "awsvpc"
	execution_role_arn       = var.aws_iam_role_ecs_task_execution_arn
	cpu                      = "1 vCPU"
	memory                   = "3 GB"

	runtime_platform {
		operating_system_family = "LINUX"
		cpu_architecture        = "X86_64"
	}

	# Container – 1
	container_definitions = jsonencode([
		{
			name         = "notes-api-container"
			image        = "${var.ecr_image_uri}:latest"
			essential    = true
			cpu          = 10
			memory       = 512
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

	tags = {
		Name        = "${var.environment}-task-definition"
		Environment = var.environment
	}
}

#resource "aws_ecs_service" "notes_ecs_service" {
#	name            = "notes-api-service"
#	cluster         = aws_ecs_cluster.notes_ecs_cluster.id
#	task_definition = aws_ecs_task_definition.notes_ecs_task_definition
#}
