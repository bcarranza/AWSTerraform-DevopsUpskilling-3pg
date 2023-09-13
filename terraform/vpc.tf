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

#creation of a custom VPC for using the custom cidr
resource "aws_vpc" "upskilling_vpc" {
  cidr_block       = local.upskilling_vpc_variables.upskilling_cidr          # CIDR block for the VPC
  instance_tenancy = "default"                   # Instance tenancy set to "default" for EC2 instances

  tags = {
    Name        = "${local.prefix}-vpc-upskilling"         # Tag the VPC with a descriptive name
  }
}
