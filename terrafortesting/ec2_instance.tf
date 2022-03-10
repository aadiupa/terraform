provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "firstecd2" {
  ami           = "ami-0dfb4b2fe71065a95"
  instance_type = "t2.micro"
}

