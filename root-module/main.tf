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
  source                    = "../eks-module"
  cluster_name              = var.cluster_name
  kubernetes_version        = var.kubernetes_version
  vpc_id                    = module.custom_vpc.vpc_id
  public_subnet_ids         = module.custom_vpc.public_subnet_ids_ordered
  admin_user_arn            = var.admin_user_arn
  github_terraform_role_arn = var.github_terraform_role_arn
  github_cicd_role_arn      = var.github_cicd_role_arn
  gitlab_cicd_role_arn      = var.gitlab_cicd_role_arn
  node_min_size             = var.node_min_size
  node_max_size             = var.node_max_size
  node_desired_size         = var.node_desired_size
}
