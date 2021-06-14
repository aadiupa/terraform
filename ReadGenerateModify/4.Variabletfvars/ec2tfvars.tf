provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "~/.aws/credentials"
  allowed_account_ids = [612053565767]
}

resource "aws_instance" "ec2" {
    ami = "ami-0c1a7f89451184c8b"
    instance_type = var.instancetype
}
