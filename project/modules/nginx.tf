#resource "aws_key_pair" "private" {
#    key_name = "private_key"
#    public_key = file("/home/user/.ssh/terraform.pub")
#}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*20*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

output "test" {
  value = data.aws_ami.ubuntu
}

resource "aws_lb" "public_nginx" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  tags = {
    Environment = "production"
  }
  security_groups = aws_security_group.sg_22_80.*.id
  subnets = aws_subnet.subnet_public.*.id
}

resource "aws_lb_target_group" "target_group_nginx" {
  name     = "target-group-nginx"
  port     = "80"
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_lb_listener" "nginx-listener" {
  load_balancer_arn = aws_lb.public_nginx.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_nginx.arn
  }
}

data "template_file" "user_data" {
  template = file("../scripts/install-nginx.yaml")
}

resource "aws_launch_template" "nginx-launch-template" {
  name          = "nginx-template"
  description   = "nginx launch template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instancetype
  #key_name    = "private_key"
  #user_data     = filebase64("example.sh")
  network_interfaces {
    associate_public_ip_address = true
    security_groups = aws_security_group.sg_22_80.*.id
  }
  user_data = base64encode(data.template_file.user_data.rendered)

  #vpc_security_group_ids = aws_security_group.sg_22_80.*.id
}


resource "aws_autoscaling_group" "nginx-autoscaling" {
  name_prefix      = "nginx"
  min_size         = 1
  max_size         = 2
  desired_capacity = 1
  launch_template {
    id = aws_launch_template.nginx-launch-template.id
  }
  health_check_type = "EC2"
  #for_each = data.aws_subnet_ids.public.ids
  vpc_zone_identifier = flatten(aws_subnet.subnet_public.*.id)
  #availability_zones = ""
  #availability_zones = ["ap-south-1a", "ap-south-1b"]

}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.nginx-autoscaling.id
  alb_target_group_arn   = aws_lb_target_group.target_group_nginx.arn
}
