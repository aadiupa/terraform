resource "aws_instance" "myec2" {
  ami                    = "ami-011c99152163a87ae"
  instance_type          = lookup(var.instance_type,terraform.workspace)
}

variable "instance_type" {
  type = map
  default = {
    default = "t2.micro"
    prod = "t2.nano"
    stage = "t2.medium"
  }
}
