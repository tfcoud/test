#creating security grp for alb

resource "aws_security_group" "alb_sg" {
  name_prefix = "orion-alb-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_lb" "lb" {
  name               = "orion-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [data.aws_subnets.default_subnet.ids[0], data.aws_subnets.default_subnet.ids[1], data.aws_subnets.default_subnet.ids[2]]
  security_groups    = [aws_security_group.alb_sg.id]
}


resource "aws_lb_target_group" "tg" {
  name     = "orion-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default_vpc.id
}



resource "aws_lb_listener" "lb_l" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.orion_asg.name
  lb_target_group_arn    = aws_lb_target_group.tg.arn
}