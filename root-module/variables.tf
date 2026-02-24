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
