# Define an AWS Application Load Balancer (ALB) resource
resource "aws_lb" "internal-alb" {
  name               = "backend"                            # Name of the ALB
  internal           = false                                # ALB is not internal
  load_balancer_type = "application"                        # ALB type is application
  security_groups    = [aws_security_group.alb-private.id]   # Security group(s) for the ALB
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]   # Subnets where the ALB will be deployed
}

# Define an AWS target group resource for the ALB
resource "aws_lb_target_group" "internal-target-alb" {
  name     = "Internal-ALB-TG"           # Name of the target group
  port     = 80                        # Port on which the target group listens
  protocol = "HTTP"                      # Protocol used by the target group
  vpc_id   = aws_vpc.this.id             # ID of the VPC where the target group is created
}

# Attach instance 1 to the target group
resource "aws_lb_target_group_attachment" "internal-attachment-1" {
  target_group_arn = aws_lb_target_group.internal-target-alb.arn    # ARN of the target group
  target_id        = aws_instance.ec2-private-1[0].id               # ID of EC2 instance 1
  port             = 80                                          # Port on which the instance listens

  depends_on = [
    aws_instance.ec2-private-1,       # Ensure instance 1 is created before attaching it to the target group
  ]
}

# Attach instance 2 to the target group
resource "aws_lb_target_group_attachment" "internal-attachment-2" {
  target_group_arn = aws_lb_target_group.internal-target-alb.arn    # ARN of the target group
  target_id        = aws_instance.ec2-private-2[0].id               # ID of EC2 instance 2
  port             = 80                                          # Port on which the instance listens

  depends_on = [
    aws_instance.ec2-private-2,       # Ensure instance 2 is created before attaching it to the target group
  ]
}

# Define a listener for the ALB
resource "aws_lb_listener" "internal-alb" {
  load_balancer_arn = aws_lb.internal-alb.arn      # ARN of the ALB
  port              = "80"                       # Port on which the listener listens
  protocol          = "HTTP"                       # Protocol used by the listener

  # Define the default action for the listener (forward traffic to the target group)
  default_action {
    type             = "forward"                   # Action type is forward
    target_group_arn = aws_lb_target_group.internal-target-alb.arn   # ARN of the target group
  }
}
