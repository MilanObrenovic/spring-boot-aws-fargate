module "vpc" {
  source               = "./modules/vpc"
  aws_region           = var.aws_region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
}
