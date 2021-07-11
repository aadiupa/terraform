provider "aws" {
  region                  = "ap-south-1"
  shared_credentials_file = "~/.aws/credentials"
  allowed_account_ids     = [612053565767]
}


resource "aws_security_group" "first" {
  name        = "allow ingress"
  description = "allow ssh traffic"

  ingress {
    description = "ssh in vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "myec2" {
  ami                    = "ami-011c99152163a87ae"
  instance_type          = "t2.micro"
  key_name               = "apnikhudki"
  vpc_security_group_ids = [aws_security_group.first.id]

  provisioner "remote-exec" {
    on_failure = continue
    inline = [
      "sudo yum -y install nano"
    ]
  }

  provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo yum remove nano"
    ]

  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./apnikhudki.pem")
    host        = self.public_ip
  }


}
