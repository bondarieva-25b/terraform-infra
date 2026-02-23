module "custom_vpc" {
  source = "../vpc-module"

  vpc_cidr             = var.vpc_cidr
  project_name         = var.project_name
  environment          = var.environment
  cluster_name         = var.cluster_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "eks" {
  source       = "../eks-module"
  cluster_name = var.cluster_name
}
