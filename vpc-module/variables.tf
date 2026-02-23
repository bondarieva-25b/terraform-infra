variable "vpc_cidr" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name (used for Kubernetes subnet tags)"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets (3 items)"

  validation {
    condition     = length(var.public_subnet_cidrs) == 3
    error_message = "public_subnet_cidrs must contain exactly 3 CIDRs."
  }
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets (3 items)"

  validation {
    condition     = length(var.private_subnet_cidrs) == 3
    error_message = "private_subnet_cidrs must contain exactly 3 CIDRs."
  }
}

variable "azs" {
  type        = list(string)
  description = "List of AZs to place subnets in (3 items)"

  validation {
    condition     = length(var.azs) == 3
    error_message = "azs must contain exactly 3 AZs."
  }
}
