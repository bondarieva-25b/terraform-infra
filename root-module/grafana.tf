# IAM Role
resource "aws_iam_role" "grafana" {
  name = "${var.cluster_name}-grafana-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRoleWithWebIdentity"
      Principal = {
        Federated = module.eks.oidc_provider_arn
      }
      Condition = {
        StringEquals = {
          "${module.eks.oidc_provider}:aud" = "sts.amazonaws.com"
          "${module.eks.oidc_provider}:sub" = "system:serviceaccount:${var.grafana_namespace}:${var.grafana_serviceaccount_name}"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy" "grafana_secrets_access" {
  name = "${var.cluster_name}-grafana-secrets-policy"
  role = aws_iam_role.grafana.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = aws_secretsmanager_secret.grafana_admin.arn
      }
    ]
  })
}

# Secret for Grafana admin password
resource "random_password" "grafana_admin" {
  length           = 28
  special          = true
  override_special = "!#$%&*+-.:=?@_"
}

resource "aws_secretsmanager_secret" "grafana_admin" {
  name        = "${var.cluster_name}-grafana-admin-creds"
  description = "Grafana admin credentials for ${var.cluster_name}"

  recovery_window_in_days = 7

  tags = {
    Project     = var.cluster_name
    Environment = var.environment
    Component   = "grafana"
    ManagedBy   = "terraform"
  }
}

resource "aws_secretsmanager_secret_version" "grafana_admin" {
  secret_id = aws_secretsmanager_secret.grafana_admin.id

  secret_string = jsonencode({
    username = var.grafana_admin_username
    password = random_password.grafana_admin.result
  })
}
