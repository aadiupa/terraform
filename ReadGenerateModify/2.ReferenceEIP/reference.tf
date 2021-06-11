provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "~/.aws/credentials"
  allowed_account_ids = [612053565767]
}


resource "aws_eip" "lb" {
    vpc = true
}

resource "aws_instance" "ec2new" {
  ami = "ami-0c1a7f89451184c8b"
  instance_type = "t2.micro"
}

resource "aws_eip_association" "associate" {
    instance_id = aws_instance.ec2new.id
    allocation_id = aws_eip.lb.id
}

resource "aws_security_group" "sg" {
    name = "first"

    ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  }
}
