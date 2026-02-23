variable "buckets" {
  type = list(string)
}

variable "s3_versioning_enabled" {
  type = string
}

variable "bucket_tags" {
  type = list(string)
}

variable "eks_name" {
  type = string
}

variable "eks_version" {
  type = string
}

variable "eks_worker_instance_types" {
  type = list(string)
}

variable "eks_asg_desired" {
  type = number
}

variable "eks_asg_max" {
  type = number
}

variable "eks_asg_min" {
  type = number
}

variable "vpc_cidr_prefix" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "admin_role_arn" {
  type = string
}

# RDS Postgres variables

variable "db_instance_identifier" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "db_name" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "backup_retention_period" {
  type = number
}

variable "rds_sg_name" {
  type = string
}
