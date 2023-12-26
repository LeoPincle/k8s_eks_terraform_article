module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr_block
  public_subnet_cidr_blocks = [cidrsubnet(var.vpc_cidr_block, 8, 1), cidrsubnet(var.vpc_cidr_block, 8, 2)]
  private_subnet_cidr_blocks = [cidrsubnet(var.vpc_cidr_block, 8, 3), cidrsubnet(var.vpc_cidr_block, 8, 4)]
}

module "name" {
  source = "./modules/eks-cluster"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}