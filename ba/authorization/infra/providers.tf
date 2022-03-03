terraform {
  required_version = "~> 1.1.0"

  required_providers {
    aws = {
      version = "~> 4.0.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {}
}
provider "aws" {
  region = var.aws_region
}