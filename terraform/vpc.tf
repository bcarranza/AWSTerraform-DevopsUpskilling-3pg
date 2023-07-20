# Crear VPC en AWS
resource "aws_vpc" "this" {
  cidr_block       = local.vpc.cidr
  instance_tenancy = "default"
  tags = {
    Name        = "${local.prefix}-vpc"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/vpc.tf"
  }
  depends_on = [
    aws_s3_bucket.this
  ]
}
