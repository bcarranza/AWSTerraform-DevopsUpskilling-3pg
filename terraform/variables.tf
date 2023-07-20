locals {
  prefix = "umg-is-tf"
  env    = "dev"
  aws = {
    region = "us-east-1"
  }
  vpc = {
    cidr    = "192.168.0.0/16"
    cidr_subnet1_private = "192.168.0.0/24"
    cidr_subnet2_private = "192.168.1.0/24"
    cidr_subnet1_public  = "192.168.2.0/24"
    cidr_subnet2_public  = "192.168.3.0/24"
    cidr_subnet1_db      = "192.168.4.0/24"
    cidr_subnet2_db      = "192.168.5.0/24"
  }
}
