# AWs flog para auditoria.
resource "aws_flow_log" "this" {
  log_destination      = aws_s3_bucket.this.arn
  traffic_type         = "ALL"
  log_destination_type = "s3"
  vpc_id = aws_vpc.this.id
}