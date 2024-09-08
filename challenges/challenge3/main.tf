data "aws_caller_identity" "current" {}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = "production"
      Application = "challenge3"
      Managedby   = "terraform"
    }
  }
}

terraform {
    # backend "s3" {
    # }
  required_version = ">= 1.6.6"
  required_providers {
    aws = {
      version = ">= 5.34.0"
      source  = "hashicorp/aws"
    }
  }
}



