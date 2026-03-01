terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "final-project-practice-058316962389-tfstate"
    key          = "infra/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
