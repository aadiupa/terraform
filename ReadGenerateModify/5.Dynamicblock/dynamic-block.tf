provider "aws" {
  region                  = "ap-south-1"
  shared_credentials_file = "~/.aws/credentials"
  allowed_account_ids     = [612053565767]
}

variable "sg_ports" {
  type        = list(number)
  description = "list of ingress"
  default     = [8200, 8300, 8400, 8500]
}

resource "aws_security_group" "dynamic" {
  name        = "dynamic sg"
  description = "ingress"


  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port  = ingress.value
      to_port    = ingress.value
      protocol   = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
