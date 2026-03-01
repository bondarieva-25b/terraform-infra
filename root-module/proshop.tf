resource "aws_iam_role" "proshop_secrets" {
  name = "proshop-backend-IRSA-role"

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
        }
      }
    }]
  })
}

resource "aws_iam_policy" "proshop_secrets" {
  name = "proshop-secret-read-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      Resource = "arn:aws:secretsmanager:us-east-1:058316962389:secret:proshop*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "proshop_secrets" {
  role       = aws_iam_role.proshop_secrets.name
  policy_arn = aws_iam_policy.proshop_secrets.arn
}

# Create empty secret for Proshop backend envs
resource "aws_secretsmanager_secret" "proshop_backend" {
  name                           = "proshop-dev-backend-app-values"
  recovery_window_in_days        = 0
  force_overwrite_replica_secret = false
}
