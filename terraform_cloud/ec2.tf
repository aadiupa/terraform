resource "aws_instance" "ec2" {
  ami = "ami-011c99152163a87ae"
  instance_type = "t2.micro"
}
