aws_region            = "eu-central-1"
environment           = "notes-api"
vpc_cidr              = "10.0.0.0/16"
public_subnets_cidr   = ["10.0.0.0/20", "10.0.16.0/20"]
private_subnets_cidr  = ["10.0.128.0/20", "10.0.144.0/20"]
ecr_repository_name   = "notes-api"
rds_subnet_group_name = "notes-api"
