data "aws_availability_zones" "azs" {}
module "myapp-vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.19.0"
  name            = "kubernetes-vpc"
  cidr            = var.vpc_cidr
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks
  azs             = data.aws_availability_zones.azs.names
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "eks-cluster" = "k8s-app"
  }

  public_subnet_tags = {
    "public-eks-cluster" = "k8s-app"
  }

  private_subnet_tags = {
    "private-eks-cluster" = "k8s-app"
  }
}