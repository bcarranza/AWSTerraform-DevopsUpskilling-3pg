# Subnet application 1
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.vpc.cidr_subnet1_private
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"
  tags = {
    Name        = "${local.prefix}-private-subnet-1"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/subnets-private.tf"
  }
  depends_on = [
    aws_vpc.this
  ]
}

# Subnet application 2
resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.vpc.cidr_subnet2_private
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"
  tags = {
    Name        = "${local.prefix}-private-subnet-2"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/subnets-private.tf"
  }
  depends_on = [
    aws_vpc.this
  ]
}