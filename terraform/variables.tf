# Define local variables to make resource names and configurations more readable and maintainable
locals {
  # Prefix for resource names to ensure uniqueness and easy identification
  prefix = "umg-is-tf"

  # Environment where the infrastructure is being deployed (e.g., "dev", "prod")
  env = "dev"

  # AWS region where the resources will be provisioned
  aws = {
    region = "us-east-1"
  }

  tag_3pg = "3pg" #this will be helpful to redefine the tags from 3pillar later 
  # VPC and subnet CIDR blocks for defining IP address ranges
  vpc = {
    cidr = "192.168.0.0/16" # CIDR block for the VPC
    # CIDR blocks for private subnets in two availability zones
    cidr_subnet1_private = "192.168.0.0/24"
    cidr_subnet2_private = "192.168.1.0/24"

    # CIDR blocks for public subnets in two availability zones
    cidr_subnet1_public = "192.168.2.0/24"
    cidr_subnet2_public = "192.168.3.0/24"

    # CIDR blocks for database subnets in two availability zones
    cidr_subnet1_db = "192.168.4.0/24"
    cidr_subnet2_db = "192.168.5.0/24"
  }
  upskilling_vpc_variables = {
    upskilling_cidr = "172.16.0.0/16" #variable for CIDR for the upskilling program
    #I think the correct subnet cidr should be with 24 of significant bits just as in the example above
    upskilling_cidr_subnet_pub = "172.16.0.0/24" #variable for CIDR public subnet for the upskilling program
    upskilling_cidr_subnet_pri = "172.16.1.0/24" #variable for CIDR private subnet for the upskilling program
  }
}
