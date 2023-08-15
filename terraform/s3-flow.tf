# Create an AWS S3 Bucket resource
# Step 3 create encrypted bucket, create key to encrypt
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "this" {
  bucket = "435924829664-bc3pg-${local.prefix}-vpc-flow-log"   # Name of the S3 bucket, generated based on the provided prefix and additional text "bc-"

  tags = {
    Name        = "${local.prefix}-vpc-flow-log"   # Tag the bucket with a descriptive name
    Environment = local.env                         # Tag the bucket with the environment
    Path        = "${basename(abspath(path.module))}/s3-flow.tf"   # Tag the bucket with the configuration file path
  }
}

# Step 3 create encrypted bucket, assign bucket to key
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
