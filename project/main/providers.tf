provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "terraformadityabackend"
    key            = "s3backend/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform_lock"
  }
}
