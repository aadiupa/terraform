provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "firstecd2" {
  ami           = "ami-0c1a7f89451184c8b"
  instance_type = "t2.micro"
}

