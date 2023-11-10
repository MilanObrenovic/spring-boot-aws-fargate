# Security Group (SG) for Application Load Balancer (ALB)
resource "aws_security_group" "ecs_alb_security_group" {
	name        = "ecs-app-load-balancer-sg"
	description = "Security group for ECS ALB."
	vpc_id      = var.vpc_id

	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name        = "${var.environment}-ecs-alb-security-group"
		Environment = var.environment
	}
}

# Security Group (SG) for API containers
resource "aws_security_group" "ecs_app_fargate_security_group" {
	name        = "ecs-app-fargate-sg"
	description = "Security group for ECS API containers."
	vpc_id      = var.vpc_id

	ingress {
		from_port       = 8080
		to_port         = 8080
		protocol        = "tcp"
		cidr_blocks     = [var.vpc_cidr_block]
		security_groups = [aws_security_group.ecs_alb_security_group.id]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name        = "${var.environment}-ecs-app-fargate-security-group"
		Environment = var.environment
	}
}

# Security Group (SG) for RDS database
resource "aws_security_group" "rds_security_group" {
	name        = "ecs-app-fargate-sg"
	description = "Security group for ECS API containers."
	vpc_id      = var.vpc_id

	ingress {
		from_port       = 8080
		to_port         = 8080
		protocol        = "tcp"
		cidr_blocks     = [var.vpc_cidr_block]
		security_groups = [aws_security_group.ecs_alb_security_group.id]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name        = "${var.environment}-ecs-app-fargate-security-group"
		Environment = var.environment
	}
}
