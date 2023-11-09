module "vpc" {
	source               = "./modules/vpc"
	aws_region           = var.aws_region
	environment          = var.environment
	vpc_cidr             = var.vpc_cidr
	private_subnets_cidr = var.private_subnets_cidr
	public_subnets_cidr  = var.public_subnets_cidr
}

module "ecr" {
	source              = "./modules/ecr"
	environment         = var.environment
	ecr_repository_name = var.ecr_repository_name
}

module "rds" {
	source                = "./modules/rds"
	environment           = var.environment
	rds_subnet_group_name = var.rds_subnet_group_name
	private_subnets_cidr  = module.vpc.private_subnet_ids
	vpc_id                = module.vpc.vpc_id
}
