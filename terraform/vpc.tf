# Create an AWS VPC resource with the specified CIDR block
resource "aws_vpc" "this" {
  cidr_block       = local.vpc.cidr              # CIDR block for the VPC
  instance_tenancy = "default"                   # Instance tenancy set to "default" for EC2 instances

  tags = {
    Name        = "${local.prefix}-vpc"         # Tag the VPC with a descriptive name
    Environment = local.env                     # Tag the VPC with the environment
    Path        = "${basename(abspath(path.module))}/vpc.tf"   # Tag the VPC with the configuration file path
  }

  depends_on = [
    aws_s3_bucket.this                           # Ensure the specified S3 bucket is created before the VPC
  ]
}

# Create an AWS VPC resource with the specified CIDR block for module 3
resource "aws_vpc" "this3" {
  cidr_block       = local.vpc.cidr_module3             # CIDR block for the VPC
  instance_tenancy = "default"                   # Instance tenancy set to "default" for EC2 instances

  tags = {
    Name        = "${local.prefix}-vpc3"         # Tag the VPC with a descriptive name
    Environment = local.env                     # Tag the VPC with the environment
    Path        = "${basename(abspath(path.module))}/vpc.tf"   # Tag the VPC with the configuration file path
  }

  depends_on = [
    aws_s3_bucket.this                           # Ensure the specified S3 bucket is created before the VPC
  ]
}
