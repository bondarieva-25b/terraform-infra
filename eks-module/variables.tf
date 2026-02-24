variable "cluster_name" {
  type        = string
  description = "EKS cluster name (used for Kubernetes subnet tags)"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the EKS cluster"
}

variable "admin_user_arn" {
  type        = string
  description = "ARN of the IAM user to be added as an admin to the EKS cluster"
}

variable "github_terraform_role_arn" {
  type        = string
  description = "ARN of the IAM role for GitHub Terraform to be added as cluster admin to the EKS cluster"
}

variable "github_cicd_role_arn" {
  type        = string
  description = "ARN of the IAM role for GitHub CI/CD to be added as an admin to the EKS cluster"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the EKS cluster will be deployed"
}
