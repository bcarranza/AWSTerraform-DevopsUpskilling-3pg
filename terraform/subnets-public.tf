# Subnet Public 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.vpc.cidr_subnet1_public
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name        = "${local.prefix}-public-subnet-1"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/subnets-public.tf"
  }
  depends_on = [
    aws_vpc.this
  ]
}

# Subnet Public 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.vpc.cidr_subnet2_public
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {
    Name        = "${local.prefix}-public-subnet-2"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/subnets-public.tf"
  }
  depends_on = [
    aws_vpc.this
  ]
}