# Security Group (SG) for Application Load Balancer (LB)
resource "aws_security_group" "notes_lb_security_group" {
	name        = "notes-lb-sg"
	description = "Security group for ECS Load Balancer."
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
		Name        = "${var.environment}-lb-security-group"
		Environment = var.environment
	}
}

# Security Group (SG) for API containers
resource "aws_security_group" "notes_fargate_security_group" {
	name        = "notes-fargate-sg"
	description = "Security group for ECS API containers."
	vpc_id      = var.vpc_id

	ingress {
		from_port       = 8080
		to_port         = 8080
		protocol        = "tcp"
		cidr_blocks     = [var.vpc_cidr_block]
		security_groups = [aws_security_group.notes_lb_security_group.id]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name        = "${var.environment}-fargate-security-group"
		Environment = var.environment
	}
}

# Security Group (SG) for RDS database
resource "aws_security_group" "notes_rds_security_group" {
	name        = "notes-rds-sg"
	description = "Security group for RDS database."
	vpc_id      = var.vpc_id

	ingress {
		from_port       = 5432
		to_port         = 5432
		protocol        = "tcp"
		cidr_blocks     = [var.vpc_cidr_block]
		security_groups = [aws_security_group.notes_fargate_security_group.id]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name        = "${var.environment}-rds-security-group"
		Environment = var.environment
	}
}
