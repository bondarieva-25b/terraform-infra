module "projectx_vpc" {
  source = "../vpc-module"

  vpc_cidr_prefix = var.vpc_cidr_prefix
  project_name    = var.project_name
  environment     = var.environment
}
