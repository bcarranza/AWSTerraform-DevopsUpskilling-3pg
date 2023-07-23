# Create an AWS Security Group resource for private instances
resource "aws_security_group" "private" {
  name_prefix = "${local.prefix}-sg-private"       # Name prefix for the security group
  description = "Private SG Group"                # Description for the security group
  vpc_id      = aws_vpc.this.id                    # ID of the VPC in which the security group will be created

  # Ingress rule: Allow all incoming traffic from the public subnets (subnet1 and subnet2)
  ingress {
    from_port   = 0                              # Ingress rule: Allow all incoming traffic (from any port)
    to_port     = 0                              # Ingress rule: Allow all incoming traffic (to any port)
    protocol    = "-1"                           # Ingress rule: Allow all protocols
    cidr_blocks = [
      local.vpc.cidr_subnet1_public,             # Ingress rule: Allow incoming traffic from public subnet 1
      local.vpc.cidr_subnet2_public              # Ingress rule: Allow incoming traffic from public subnet 2
    ]
  }

  # Ingress rule: Allow incoming traffic on port 8081 (HTTP) from the ALB's security group
  ingress {
    from_port       = 8081                       # Ingress rule: Allow incoming traffic on port 8081 (HTTP)
    to_port         = 8081                       # Ingress rule: Allow incoming traffic on port 8081 (HTTP)
    protocol        = "tcp"                      # Ingress rule: Allow TCP traffic
    security_groups = [aws_security_group.alb-private.id]  # Ingress rule: Allow traffic from the ALB's security group
  }

  egress {
    from_port   = 0                              # Egress rule: Allow all outgoing traffic
    to_port     = 0                              # Egress rule: Allow all outgoing traffic
    protocol    = "-1"                           # Egress rule: Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]                   # Egress rule: Allow outgoing traffic to any IP (0.0.0.0/0)
  }

  depends_on = [
    aws_vpc.this                                # Ensure VPC is created before the security group
  ]
}
