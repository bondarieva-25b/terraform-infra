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

# Cert Manager Outputs
output "cert_manager_role_arn" {
  value = aws_iam_role.cert_manager.arn
}

output "hosted_zone_id" {
  value = data.aws_route53_zone.main.zone_id
}
