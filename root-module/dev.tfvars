# VPC configs
project_name         = "fp"
vpc_cidr             = "10.0.0.0/16"
environment          = "dev"
cluster_name         = "fp-eks"
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

# EKS configs
kubernetes_version        = "1.34"
admin_user_arn            = ""
github_terraform_role_arn = "arn:aws:iam::058316962389:role/GitHubActionsTFRole"
github_cicd_role_arn      = "arn:aws:iam::058316962389:role/GitHubActionsCICDRole"
node_min_size             = 1
node_max_size             = 3
node_desired_size         = 2

# Grafana configs
grafana_admin_username      = "admin"
grafana_namespace           = "monitoring"
grafana_serviceaccount_name = "grafana-sa"
