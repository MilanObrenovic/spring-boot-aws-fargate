# Subnet groups
resource "aws_db_subnet_group" "default" {
	name       = "main"
	subnet_ids = var.private_subnets_cidr

	tags = {
		Name        = "${var.environment}-subnet-group"
		Environment = var.environment
	}
}
