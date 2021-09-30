resource "aws_instance" "myec3" {
    ami = "ami-011c99152163a87ae"
    instance_type = "t2.micro"
}
