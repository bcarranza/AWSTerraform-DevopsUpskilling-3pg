# Create an AWS S3 Bucket resource
resource "aws_s3_bucket" "this" {
  bucket = "435924829664-bc3pg-farce-${local.prefix}-vpc-flow-log"   # Name of the S3 bucket, generated based on the provided prefix and additional text "bc-"
  
 server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${local.prefix}-vpc-flow-log"   # Tag the bucket with a descriptive name
    Environment = local.env                         # Tag the bucket with the environment
    Path        = "${basename(abspath(path.module))}/s3-flow.tf"   # Tag the bucket with the configuration file path
  }
}
