# Create an AWS Security Group resource for the DB instances
resource "aws_security_group" "db" {
  name_prefix = "${local.prefix}-sg-db"         # Name prefix for the security group
  description = "DB SG Group"                  # Description for the security group
  vpc_id      = aws_vpc.this.id                # ID of the VPC in which the security group will be created

  ingress {
    from_port   = 0                          # Ingress rule: Allow all incoming traffic (from any port)
    to_port     = 0                          # Ingress rule: Allow all incoming traffic (to any port)
    protocol    = "-1"                       # Ingress rule: Allow all protocols
    cidr_blocks = [
      local.vpc.cidr_subnet1_private,        # Ingress rule: Allow incoming traffic from private subnet 1
      local.vpc.cidr_subnet2_private,        # Ingress rule: Allow incoming traffic from private subnet 2
      local.upskilling_vpc_variables.upskilling_cidr_subnet_pri #ingress rule: Allow incoming traffic from public upskilling requirement
    ]
  }

  egress {
    from_port   = 0                          # Egress rule: Allow all outgoing traffic
    to_port     = 0                          # Egress rule: Allow all outgoing traffic
    protocol    = "-1"                       # Egress rule: Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]               # Egress rule: Allow outgoing traffic to any IP (0.0.0.0/0)
  }

  depends_on = [
    aws_vpc.this,                            # Ensure VPC is created before the security group
    aws_vpc.upskilling_vpc
  ]
}
