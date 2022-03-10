provider "aws" {
  region = "us-east-2"

}

terraform {
  backend "s3" {}
}

resource "aws_instance" "firstecd2" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
}

