# 🏗️ Terraform Infrastructure

AWS infrastructure for the EKS platform, managed entirely through Terraform.

## 🌐 What It Deploys

### 🔵 VPC Module
VPC with public and private subnets across 3 AZs, Internet Gateway, and route tables.

### 🟠 EKS Module
- EKS cluster (Kubernetes 1.34) with API authentication mode
- Self-managed nodes via ASG — 80% spot / 20% on-demand with 3 instance types
- AL2023 EKS-optimized AMI with nodeadm bootstrap
- Add-ons: VPC CNI, CoreDNS, kube-proxy, EBS CSI driver, Pod Identity agent
- OIDC provider for IRSA

### 🟣 Platform IRSA Roles (root module)
- 🔒 **cert-manager** — Route 53 access for DNS-01 TLS challenges
- 🌍 **external-dns** — Route 53 access for automatic DNS record management
- 📊 **grafana** — Secrets Manager for admin credentials
- 🛒 **proshop** — Secrets Manager access for backend app secrets

## 📦 Prerequisites

- AWS CLI configured
- Terraform >= 1.13.3
- S3 bucket for remote state

---

## ⚠️ Remote Backend — Read This First

Terraform stores a **state file** that tracks every resource it manages. The remote backend stores this state in S3 so that everyone (and CI/CD) works from the same source of truth.

### 🔧 How to configure

Your backend is configured in `providers.tf`:

```hcl
terraform {
  backend "s3" {
    bucket       = "final-project-practice-058316962389-tfstate"
    key          = "infra/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
```

`use_lockfile = true` enables S3-native state locking (available in Terraform 1.13.3+). No DynamoDB table needed — Terraform creates a `.tflock` file in the same S3 bucket to prevent concurrent applies.

Before running anything:

1. ✅ Make sure the S3 bucket exists in your AWS account
2. ✅ Run `terraform init` — this connects Terraform to the remote state

### 🚨 Can I run both locally and through GitHub Actions?

**Yes!** As long as both are pointing to the **same AWS account** and the **same S3 state bucket**, it works fine. Terraform uses S3-native locking (`use_lockfile = true`) to prevent two applies from running at the same time.

The problems start when people use **different AWS accounts** locally vs in CI — then you get half your resources in one account and half in another. As long as the account and state bucket match, you're good.

### ✅ Quick check before running

```bash
# This should show the same account ID you use in GitHub Actions
aws sts get-caller-identity
```

---

## 💻 Running Locally

```bash
# 1. Navigate to root module
cd root-module

# 2. Initialize (downloads providers, connects to remote state)
terraform init

# 3. Preview changes
terraform plan -var-file=dev.tfvars

# 4. Apply changes
terraform apply -var-file=dev.tfvars
```

---

## 🚀 Running Through GitHub Actions

The pipeline runs automatically on push:

```
Push to any branch     →  ✅ terraform plan →  ▶️ terraform apply
```

GitHub Actions authenticates to AWS using **OIDC** — no static credentials. The workflow assumes an IAM role via `aws-actions/configure-aws-credentials`, which points to the same AWS account and same S3 backend as local runs.

---

## 🔥 Common Mistakes to Avoid

| ❌ Mistake | ✅ Fix |
|---|---|
| Local CLI uses account A, GitHub Actions uses account B | Make sure both use the **same AWS account** |
| Forgot `terraform init` after cloning | Always run `init` first |
| Using wrong `.tfvars` file | Double check: `dev.tfvars` for dev |
| Running `apply` without reviewing `plan` | Always read the plan output before applying |
| S3 backend bucket is in a different account | Backend bucket must be in the same account you're deploying to |
| Using Terraform < 1.13.3 | `use_lockfile` requires Terraform 1.13.3+. Run `terraform version` to check |

---

## 📤 Outputs

| Output | Description |
|---|---|
| 🏷️ `cluster_name` | EKS cluster name |
| 🔗 `cluster_endpoint` | EKS API endpoint |
| 📌 `cluster_version` | Kubernetes version |
| ⌨️ `configure_kubectl` | Command to set up kubeconfig |
| 🔒 `cert_manager_role_arn` | IRSA role for cert-manager |
| 🌍 `external_dns_role_arn` | IRSA role for external-dns |
| 🗺️ `hosted_zone_id` | Route 53 hosted zone ID |
| 🛒 `proshop_secrets_role_arn` | IRSA role for proshop backend |
| 🔑 `proshop_secret_name` | Secrets Manager secret name |
