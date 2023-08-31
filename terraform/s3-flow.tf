# Create an AWS S3 Bucket resource
resource "aws_s3_bucket" "this" {
  bucket = "mike-435924829664-bc3pg-${local.prefix}-vpc-flow-log"   # Name of the S3 bucket, generated based on the provided prefix and additional text "bc-"

  tags = {
    Name        = "${local.prefix}-vpc-flow-log"   # Tag the bucket with a descriptive name
    Environment = local.env                         # Tag the bucket with the environment
    Path        = "${basename(abspath(path.module))}/s3-flow.tf"   # Tag the bucket with the configuration file path
  }

  # Add encryption for flow bucket.
  server_side_encryption_configuration {
    rule {
      apply_server_side_encyrption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
