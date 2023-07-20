# Subnet Database 1
resource "aws_subnet" "db-subnet-1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.vpc.cidr_subnet1_db
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"
  tags = {
    Name        = "${local.prefix}-db-subnet-1"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/subnets-db.tf"
  }
  depends_on = [
    aws_vpc.this
  ]
}

# Subnet Database 2
resource "aws_subnet" "db-subnet-2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.vpc.cidr_subnet2_db
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"
  tags = {
    Name        = "${local.prefix}-db-subnet-2"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/subnets-db.tf"
  }
  depends_on = [
    aws_vpc.this
  ]
}