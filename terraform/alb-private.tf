# Creating External LoadBalancer
resource "aws_lb" "internal-alb" {
  name               = "backend"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-private.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

resource "aws_lb_target_group" "internal-target-alb" {
  name     = "Internal-ALB-TG"
  port     = 8081
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
}

resource "aws_lb_target_group_attachment" "internal-attachment-1" {
  target_group_arn = aws_lb_target_group.internal-target-alb.arn
  target_id        = aws_instance.ec2-private-1[0].id
  port             = 8081

  depends_on = [
    aws_instance.ec2-private-1,
  ]
}

resource "aws_lb_target_group_attachment" "internal-attachment-2" {
  target_group_arn = aws_lb_target_group.internal-target-alb.arn
  target_id        = aws_instance.ec2-private-2[0].id
  port             = 8081

  depends_on = [
    aws_instance.ec2-private-2,
  ]
}

resource "aws_lb_listener" "internal-alb" {
  load_balancer_arn = aws_lb.internal-alb.arn
  port              = "8081"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal-target-alb.arn
  }
}