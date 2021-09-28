# Terraform Block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.58.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {}
}

# Provider Block
provider "aws" {
  region = var.aws_region
}

# Create Random Pet Resource
resource "random_pet" "this" {
  length = 2
}
