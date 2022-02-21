terraform {
  backend "s3" {
    bucket         = "terraformadityabackend2"
    key            = "s3backend/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform_lock"
  }
}