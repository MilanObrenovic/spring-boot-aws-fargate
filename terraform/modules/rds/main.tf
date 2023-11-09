# Subnet groups
resource "aws_db_subnet_group" "rds_subnet_group" {
	name       = var.rds_subnet_group_name
	subnet_ids = var.private_subnets_cidr

	tags = {
		Name        = "${var.environment}-subnet-group"
		Environment = var.environment
	}
}

# Security Group (SG)
resource "aws_security_group" "rds_security_group" {
	name        = "spring-boot-aws-fargate-rds-security-group"
	description = "Security group for RDS instance."
	vpc_id      = var.vpc_id

	ingress {
		from_port   = 5432
		to_port     = 5432
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
		Name        = "${var.environment}-rds-security-group"
		Environment = var.environment
	}
}

# PostgreSQL RDS
resource "aws_db_instance" "rds" {
	# Engine options
	engine         = "postgres"
	engine_version = "15.3"

	# Settings
	db_name  = "spring_boot_aws_fargate_db"
	username = "postgres"
	password = "password"

	# Instance configuration
	instance_class = "db.t3.micro"

	# Storage
	storage_type      = "gp2"
	allocated_storage = 20

	# Connectivity
	network_type           = "IPV4"
	vpc_security_group_ids = [aws_security_group.rds_security_group.id]
	db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
	publicly_accessible    = false
	ca_cert_identifier     = "rds-ca-2019"

	# Additional configuration
	parameter_group_name      = "default.postgres15"
	option_group_name         = "default:postgres-15"
	skip_final_snapshot       = true

	tags = {
		Name        = "${var.environment}-rds"
		Environment = var.environment
	}
}
