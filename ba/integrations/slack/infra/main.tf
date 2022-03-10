terraform {
  required_version = "~> 1.1.0"

  required_providers {
    aws = {
      version = "~> 4.0.0"
      source  = "hashicorp/aws"
    }
  }
 
}
provider "aws" {
  region = "us-east-2"
}


resource "null_resource" "cluster" {
  # Won't do anything

}