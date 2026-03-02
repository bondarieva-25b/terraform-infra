# VPC outputs
output "vpc_id" {
  value = module.custom_vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.custom_vpc.private_subnet_ids_ordered
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_version" {
  value = module.eks.cluster_version
}

output "configure_kubectl" {
  value = "aws eks update-kubeconfig --region us-east-1 --name ${module.eks.cluster_name}"
}

# EKS node security group output
output "eks_node_security_group_id" {
  value = module.eks.node_security_group_id
}

# Cert Manager Outputs
output "cert_manager_role_arn" {
  value = aws_iam_role.cert_manager.arn
}

output "hosted_zone_id" {
  value = data.aws_route53_zone.main.zone_id
}

# External DNS Outputs
output "external_dns_role_arn" {
  value = aws_iam_role.external_dns.arn
}

# Grafana Outputs
output "grafana_admin_secret_name" {
  value = aws_secretsmanager_secret.grafana_admin.name
}

output "grafana_admin_secret_arn" {
  value = aws_secretsmanager_secret.grafana_admin.arn
}

output "grafana_irsa_role_arn" {
  value = aws_iam_role.grafana.arn
}

# Proshop Outputs
output "proshop_secrets_role_arn" {
  value = aws_iam_role.proshop_secrets.arn
}

output "proshop_secret_name" {
  value = aws_secretsmanager_secret.proshop_backend.name
}

# Karpenter Outputs
output "karpenter_controller_role_arn" {
  value = aws_iam_role.karpenter_controller.arn
}

output "karpenter_node_role_arn" {
  value = aws_iam_role.karpenter_node.arn
}

output "karpenter_instance_profile_name" {
  value = aws_iam_instance_profile.karpenter_node.name
}

output "karpenter_queue_name" {
  value = aws_sqs_queue.karpenter.name
}
