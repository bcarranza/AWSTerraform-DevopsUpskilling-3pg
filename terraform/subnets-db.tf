# Create an AWS Subnet resource for the database in the first availability zone (us-east-1a)
resource "aws_subnet" "db-subnet-1" {
  vpc_id                  = aws_vpc.this.id                # ID of the VPC in which the subnet will be created
  cidr_block              = local.vpc.cidr_subnet1_db      # CIDR block for the subnet
  map_public_ip_on_launch = false                         # Do not assign public IPs to instances launched in this subnet
  availability_zone       = "us-east-1a"                  # Availability zone for the subnet

  tags = {
    Name        = "${local.prefix}-db-subnet-1"           # Tag the subnet with a descriptive name
    Environment = local.env                               # Tag the subnet with the environment
    Path        = "${basename(abspath(path.module))}/subnets-db.tf"   # Tag the subnet with the configuration file path
  }

  depends_on = [
    aws_vpc.this                                          # Ensure VPC is created before the subnet
  ]
}

# Create an AWS Subnet resource for the database in the second availability zone (us-east-1b)
resource "aws_subnet" "db-subnet-2" {
  vpc_id                  = aws_vpc.this.id                # ID of the VPC in which the subnet will be created
  cidr_block              = local.vpc.cidr_subnet2_db      # CIDR block for the subnet
  map_public_ip_on_launch = false                         # Do not assign public IPs to instances launched in this subnet
  availability_zone       = "us-east-1b"                  # Availability zone for the subnet

  tags = {
    Name        = "${local.prefix}-db-subnet-2"           # Tag the subnet with a descriptive name
    Environment = local.env                               # Tag the subnet with the environment
    Path        = "${basename(abspath(path.module))}/subnets-db.tf"   # Tag the subnet with the configuration file path
  }

  depends_on = [
    aws_vpc.this                                          # Ensure VPC is created before the subnet
  ]
}

resource "aws_db_subnet_group" "db" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.db-subnet-1.id, aws_subnet.db-subnet-2.id]
}