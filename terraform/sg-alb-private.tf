# Creating a mainly security group 
resource "aws_security_group" "alb-private" {
  name_prefix = "${local.prefix}-sg-alb-private"
  description = "Private ALB SG Group"
  vpc_id      = aws_vpc.this.id
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    # Damos permiso desde el mundo exterior
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [
    aws_vpc.this
  ]
}