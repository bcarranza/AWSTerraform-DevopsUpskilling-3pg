# Create an AWS Subnet resource for private instances in the first availability zone (us-east-1a)
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.this.id                # ID of the VPC in which the subnet will be created
  cidr_block              = local.vpc.cidr_subnet1_private # CIDR block for the subnet
  map_public_ip_on_launch = false                         # Do not assign public IPs to instances launched in this subnet
  availability_zone       = "us-east-1a"                  # Availability zone for the subnet

  tags = {
    Name        = "${local.prefix}-private-subnet-1"      # Tag the subnet with a descriptive name
    Environment = local.env                               # Tag the subnet with the environment
    Path        = "${basename(abspath(path.module))}/subnets-private.tf"   # Tag the subnet with the configuration file path
  }

  depends_on = [
    aws_vpc.this                                          # Ensure VPC is created before the subnet
  ]
}

# Create an AWS Subnet resource for private instances in the second availability zone (us-east-1b)
resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.this.id                # ID of the VPC in which the subnet will be created
  cidr_block              = local.vpc.cidr_subnet2_private # CIDR block for the subnet
  map_public_ip_on_launch = false                         # Do not assign public IPs to instances launched in this subnet
  availability_zone       = "us-east-1b"                  # Availability zone for the subnet

  tags = {
    Name        = "${local.prefix}-private-subnet-2"      # Tag the subnet with a descriptive name
    Environment = local.env                               # Tag the subnet with the environment
    Path        = "${basename(abspath(path.module))}/subnets-private.tf"   # Tag the subnet with the configuration file path
  }

  depends_on = [
    aws_vpc.this                                          # Ensure VPC is created before the subnet
  ]
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id                  = aws_vpc.vpc_alt.id                # ID of the VPC in which the subnet will be created
  cidr_block              = local.vpc_alt.cidr_subnet1_private # CIDR block for the subnet
  map_public_ip_on_launch = false                         # Do not assign public IPs to instances launched in this subnet
  availability_zone       = "us-east-1c"                  # Availability zone for the subnet

  tags = {
    Name        = "${local.prefix}-private-subnet-3"      # Tag the subnet with a descriptive name
    Environment = local.env                               # Tag the subnet with the environment
    Path        = "${basename(abspath(path.module))}/subnets-private.tf"   # Tag the subnet with the configuration file path
  }

  depends_on = [
    aws_vpc.vpc_alt                                          # Ensure VPC is created before the subnet
  ]
}
