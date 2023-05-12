
# Configuring all providers here
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAQWZTKH34SDHFL5GR"
  secret_key = "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"
}

