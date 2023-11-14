# ECS cluster
resource "aws_ecs_cluster" "notes_ecs_cluster" {
	name = "notes-api-dev-cluster"

	tags = {
		Name        = "${var.environment}-ecs-cluster"
		Environment = var.environment
	}
}

# Configure the above ECS Cluster to support FARGATE_SPOT instead of FARGATE
resource "aws_ecs_cluster_capacity_providers" "notes_ecs_cluster_capacity_providers" {
	cluster_name       = aws_ecs_cluster.notes_ecs_cluster.name
	capacity_providers = ["FARGATE_SPOT", "FARGATE"]

	default_capacity_provider_strategy {
		base              = 0
		weight            = 1
		capacity_provider = "FARGATE_SPOT"
	}
}

# For service discovery
resource "aws_service_discovery_http_namespace" "notes_service_discovery_http_namespace" {
	name = aws_ecs_cluster.notes_ecs_cluster.name

	tags = {
		AmazonECSManaged = "true"
	}
}

# Task definition
resource "aws_ecs_task_definition" "notes_ecs_task_definition" {
	# Task definition configuration
	family = "notes-api-task-definition"

	# Infrastructure requirements
	requires_compatibilities = ["FARGATE"]
	network_mode             = "awsvpc"
	execution_role_arn       = "arn:aws:iam::396280700779:role/ecsTaskExecutionRole"
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
			cpu          = 0
			portMappings = [
				{
					name          = "notes-api-container-8080-tcp",
					containerPort = 8080
					hostPort      = 8080,
					protocol      = "tcp",
					appProtocol   = "http"
				}
			],
			essential   = true
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
			],
			environmentFiles = [],
			mountPoints      = [],
			volumesFrom      = [],
			ulimits          = []
		}
	])

	tags = {
		Name        = "${var.environment}-task-definition"
		Environment = var.environment
	}
}

resource "aws_lb" "notes_lb" {
	name                       = "notes-api-ecs-lb"
	load_balancer_type         = "application"
	security_groups            = [var.notes_lb_security_group_id]
	subnets                    = var.public_subnets_cidr
	enable_deletion_protection = false

	tags = {
		Name        = "${var.environment}-ecs-lb"
		Environment = var.environment
	}
}

resource "aws_lb_target_group" "notes_lb_target_group" {
	name        = "notes-api-ecs-tg"
	protocol    = "HTTP"
	target_type = "ip"
	port        = 8080
	vpc_id      = var.vpc_id

	health_check {
		path                = "/actuator/health"
		protocol            = "HTTP"
		enabled             = true
		interval            = 30
		timeout             = 5
		healthy_threshold   = 10
		unhealthy_threshold = 2
	}

	lifecycle {
		create_before_destroy = true
	}

	tags = {
		Name        = "${var.environment}-ecs-tg"
		Environment = var.environment
	}
}

resource "aws_lb_listener" "notes_lb_listener" {
	load_balancer_arn = aws_lb.notes_lb.arn
	protocol          = "HTTP"
	port              = 80

	default_action {
		type             = "forward"
		target_group_arn = aws_lb_target_group.notes_lb_target_group.arn
	}

	lifecycle {
		create_before_destroy = true
	}

	tags = {
		Name        = "${var.environment}-ecs-lb-listener"
		Environment = var.environment
	}
}

# ECS service
resource "aws_ecs_service" "notes_ecs_service" {
	# Deployment configuration
	name                              = "notes-api-service"
	cluster                           = aws_ecs_cluster.notes_ecs_cluster.id
	task_definition                   = aws_ecs_task_definition.notes_ecs_task_definition.arn
	launch_type                       = "FARGATE"
	desired_count                     = 1
	health_check_grace_period_seconds = 0

	# Networking
	network_configuration {
		subnets          = var.private_subnets_cidr
		security_groups  = [var.notes_fargate_security_group_id]
		assign_public_ip = false
	}

	# Load balancing
	load_balancer {
		container_name   = "notes-api-container"
		target_group_arn = aws_lb_target_group.notes_lb_target_group.arn
		container_port   = 8080
	}

	tags = {
		Name        = "${var.environment}-ecs-service"
		Environment = var.environment
	}
}
