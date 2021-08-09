resource "aws_lb" "public_nginx" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  tags = {
    Environment = "production"
  }
  subnets = tolist(["subnet-81bcdffa", "subnet-098d6662", "subnet-05fea749"])
}

resource "aws_lb_target_group" "target_group_nginx" {
  name     = "target-group-nginx"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "vpc-0bf93b60"
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

resource "aws_launch_template" "nginx-launch-template" {
  name        = "nginx-template"
  description = "nginx launch template"
  image_id      = "ami-04db49c0fb2215364"
  instance_type = "t2.micro"
}


resource "aws_autoscaling_group" "nginx-autoscaling" {
  name_prefix      = "nginx"
  min_size         = 1
  max_size         = 2
  desired_capacity = 1
  launch_template {
    id = aws_launch_template.nginx-launch-template.id
  }
  availability_zones = ["ap-south-1a","ap-south-1b"]
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.nginx-autoscaling.id
  alb_target_group_arn   = aws_lb_target_group.target_group_nginx.arn
}
