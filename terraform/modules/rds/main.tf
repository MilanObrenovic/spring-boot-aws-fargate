# Subnet groups
resource "aws_db_subnet_group" "rds_subnet_group" {
	name       = var.rds_subnet_group_name
	subnet_ids = var.private_subnets_cidr

	tags = {
		Name        = "${var.environment}-subnet-group"
		Environment = var.environment
	}
}

# PostgreSQL RDS
resource "aws_db_instance" "rds" {
	# Engine options
	engine         = "postgres"
	engine_version = "15.3"

	# Settings
	db_name  = "notes_db"
	username = "postgres"
	password = "password"

	# Instance configuration
	instance_class = "db.t3.micro"

	# Storage
	storage_type      = "gp2"
	allocated_storage = 20

	# Connectivity
	network_type           = "IPV4"
	vpc_security_group_ids = [var.rds_security_group_id]
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
