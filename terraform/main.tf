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

module "sg" {
	source         = "./modules/sg"
	environment    = var.environment
	vpc_id         = module.vpc.vpc_id
	vpc_cidr_block = module.vpc.vpc_cidr_block
}

module "rds" {
	source                = "./modules/rds"
	environment           = var.environment
	rds_subnet_group_name = var.rds_subnet_group_name
	private_subnets_cidr  = module.vpc.private_subnet_ids
	vpc_id                = module.vpc.vpc_id
	rds_security_group_id = module.sg.notes_rds_security_group_id
}

module "ecs" {
	source                          = "./modules/ecs"
	environment                     = var.environment
	ecr_image_uri                   = module.ecr.ecr_image_uri
	rds_database_host_name          = module.rds.rds_database_host_name
	notes_fargate_security_group_id = module.sg.notes_fargate_security_group_id
	private_subnets_cidr            = module.vpc.private_subnet_ids
	vpc_id                          = module.vpc.vpc_id
	notes_lb_security_group_id      = module.sg.notes_lb_security_group_id
	public_subnets_cidr             = module.vpc.public_subnet_ids
}

module "route53" {
	source                                        = "./modules/route53"
	environment                                   = var.environment
	notes_lb_dns_name                             = module.ecs.notes_lb_dns_name
	notes_lb_zone_id                              = module.ecs.notes_lb_zone_id
	aws_acm_certificate_domain_validation_options = module.acm.aws_acm_certificate_domain_validation_options
}

module "acm" {
	source          = "./modules/acm"
	environment     = var.environment
	route53_zone_id = module.route53.aws_route53_zone_id
}
