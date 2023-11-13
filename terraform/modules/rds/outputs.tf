output "rds_database_host_name" {
	# Endpoint returns RDS database hostname + port, so take only the hostname
	value = split(":", aws_db_instance.rds.endpoint)[0]
}
