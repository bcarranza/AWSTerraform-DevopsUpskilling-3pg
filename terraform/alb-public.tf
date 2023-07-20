# Creating External LoadBalancer
resource "aws_lb" "external-alb" {
  name               = "frontend"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-public.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

resource "aws_lb_target_group" "external-target-elb" {
  name     = "External-ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
}

resource "aws_lb_target_group_attachment" "external-attachment-1" {
  target_group_arn = aws_lb_target_group.external-target-elb.arn
  target_id        = aws_instance.ec2-public-1[0].id
  port             = 80

  depends_on = [
    aws_instance.ec2-public-1,
  ]
}

resource "aws_lb_target_group_attachment" "external-attachment-2" {
  target_group_arn = aws_lb_target_group.external-target-elb.arn
  target_id        = aws_instance.ec2-public-2[0].id
  port             = 80

  depends_on = [
    aws_instance.ec2-public-2,
  ]
}

resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external-target-elb.arn
  }
}