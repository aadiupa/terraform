resource "aws_instance" "ec2" {
  ami = "ami-011c99152163a87ae"
  instance_type = "t2.micro"
}


resource "aws_instance" "ec2_europe" {
  ami = "ami-02b4e72b17337d6c1"
  instance_type = "t2.micro"
  provider = aws.europe
}
