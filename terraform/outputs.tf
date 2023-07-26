# Output the name of the S3 bucket created (in the `aws_s3_bucket` resource).
output "s3_bucket_name" {
  value = aws_s3_bucket.this.bucket
}

# Output the ID of the VPC created (in the `aws_vpc` resource).
output "vpc_id" {
  value = aws_vpc.this.id
}

# Output the ID of the flow log created (in the `aws_flow_log` resource).
output "flow_log_id" {
  value = aws_flow_log.this.id
}

# Output the DNS name of the external Application Load Balancer (in the `aws_lb` resource).
output "load_balancer_external_dns" {
  value       = aws_lb.external-alb.dns_name
  description = "DNS name for the external Application Load Balancer"
}

# Output the DNS name of the internal Application Load Balancer (in the `aws_lb` resource).
output "load_balancer_internal_dns" {
  value       = aws_lb.internal-alb.dns_name
  description = "DNS name for the internal Application Load Balancer"
}

# Output the private DNS name of the database RDS instance (in the `aws_instance` resource).
output "db_instance_endpoint" {
  value       = aws_db_instance.myinstance.endpoint
}

