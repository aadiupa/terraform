provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "~/.aws/credentials"
  allowed_account_ids = [612053565767]
}

resource "aws_security_group" "first" {
    name = "newsg"

    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = [var.vpn_id]
    }

    ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = [var.vpn_id]
    }

    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [var.vpn_id]
    }


}
