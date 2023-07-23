# Create an AWS VPC Flow Log resource
resource "aws_flow_log" "this" {
  log_destination      = aws_s3_bucket.this.arn  # ARN of the S3 bucket where flow logs will be stored
  traffic_type         = "ALL"                  # Capture all traffic for the flow logs
  log_destination_type = "s3"                   # Store flow logs in an S3 bucket
  vpc_id               = aws_vpc.this.id         # ID of the VPC for which flow logs will be enabled
}
