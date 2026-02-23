locals {
  vpc_cidr = var.vpc_cidr
  igw_tag  = "${var.project_name}-${var.environment}-igw"

  public_subnets = {
    public_1 = { cidr = var.public_subnet_cidrs[0], az = var.azs[0] }
    public_2 = { cidr = var.public_subnet_cidrs[1], az = var.azs[1] }
    public_3 = { cidr = var.public_subnet_cidrs[2], az = var.azs[2] }
  }

  private_subnets = {
    private_1 = { cidr = var.private_subnet_cidrs[0], az = var.azs[0] }
    private_2 = { cidr = var.private_subnet_cidrs[1], az = var.azs[1] }
    private_3 = { cidr = var.private_subnet_cidrs[2], az = var.azs[2] }
  }
}
