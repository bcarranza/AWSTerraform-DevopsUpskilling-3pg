# Create an AWS S3 Bucket resource
resource "aws_s3_bucket" "this" {
  bucket = "435924829664-bc3pg-${local.prefix}-vpc-flow-log"   # Name of the S3 bucket, generated based on the provided prefix and additional text "bc-"

  tags = {
    Name        = "${local.prefix}-vpc-flow-log"   # Tag the bucket with a descriptive name
    Environment = local.env                         # Tag the bucket with the environment
    Path        = "${basename(abspath(path.module))}/s3-flow.tf"   # Tag the bucket with the configuration file path
  }

  # so I don't have to manually delete the bucket manually, https://dev.to/the_cozma/terraform-handling-the-deletion-of-a-non-empty-aws-s3-bucket-3jg3
  force_destroy = true

  #encrypt the s3 bucket
  # ??? seems like it should be "aws_s3_bucket_" prefix a la https://stackoverflow.com/a/75925563/254477 , but doesn't seem to work
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
