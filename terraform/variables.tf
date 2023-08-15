# Define local variables to make resource names and configurations more readable and maintainable
locals {
  # Prefix for resource names to ensure uniqueness and easy identification
  prefix = "umg-is-tf"

  # Environment where the infrastructure is being deployed (e.g., "dev", "prod")
  env    = "dev"

  # AWS region where the resources will be provisioned
  aws = {
    region = "us-east-2"
  }

  # VPC and subnet CIDR blocks for defining IP address ranges
  vpc = {
	# Step 1 set new CIDRs: set vpc cidr to 172.16.0.0
    cidr    = "172.16.0.0/16"        # CIDR block for the VPC

    # CIDR blocks for private subnets in one availability zone
	# Step 1 set new CIDRs: set private subnet cidr to 172.16.1.0
    cidr_subnet1_private = "172.16.1.0/24"

    # CIDR blocks for public subnets in one availability zone
	# Step 1 set new CIDRs: set public subnet cidr to 172.16.0.0
    cidr_subnet1_public  = "172.16.0.0/24"

    # CIDR blocks for database subnets in one availability zone
    cidr_subnet1_db      = "192.168.4.0/24"
  }
}
