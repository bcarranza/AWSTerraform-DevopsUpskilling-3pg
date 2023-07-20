# Creating a mainly security group 
resource "aws_security_group" "db" {
  name_prefix = "${local.prefix}-sg-db"
  description = "DB SG Group"
  vpc_id      = aws_vpc.this.id
  ingress {
    # Es probable que modifiquemos y solo demos permiso al puerto de bd.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    # Solo damos permiso hacia la bd desde la vpc interna
    cidr_blocks = [local.vpc.cidr_subnet1_private, local.vpc.cidr_subnet2_private]
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