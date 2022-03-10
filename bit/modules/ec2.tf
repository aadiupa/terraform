resource "aws_instance" "myec3" {
    ami = var.ami
    instance_type = var.instance_type
    lifecycle {
    prevent_destroy = true
  }
}
