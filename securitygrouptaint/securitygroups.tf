resource "aws_security_group" "securitygroup1" {
    name = "allow_traffic"
    description = "allow all traffic"
    vpc_id = "vpc-0bf93b60"

    ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
}
