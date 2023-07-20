# Creating a mainly security group 
resource "aws_security_group" "private" {
  name_prefix = "${local.prefix}-sg-private"
  description = "Private SG Group"
  vpc_id      = aws_vpc.this.id
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    # Solo damos permiso hacia la bd desde la subnet publica (frontend)
    cidr_blocks = [local.vpc.cidr_subnet1_public, local.vpc.cidr_subnet2_public]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    # Solo damos permiso hacia la bd desde la subnet publica (frontend)
    security_groups = [aws_security_group.alb-private.id]
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