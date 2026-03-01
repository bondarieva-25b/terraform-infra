# VPC module
variable "vpc_cidr" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

# EKS module
variable "kubernetes_version" {
  type = string
}

variable "admin_user_arn" {
  type = string
}

variable "github_terraform_role_arn" {
  type = string
}

variable "github_cicd_role_arn" {
  type = string
}

variable "gitlab_cicd_role_arn" {
  type = string
}

# ASG
variable "node_min_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

variable "node_desired_size" {
  type = number
}

# Grafana
variable "grafana_admin_username" {
  type        = string
  description = "Grafana admin username stored in Secrets Manager"
  default     = "admin"
}

variable "grafana_namespace" {
  type        = string
  description = "Namespace where Grafana runs"
  default     = "monitoring"
}

variable "grafana_serviceaccount_name" {
  type        = string
  description = "Grafana ServiceAccount name (must match Helm chart SA)"
  default     = "grafana-sa"
}
