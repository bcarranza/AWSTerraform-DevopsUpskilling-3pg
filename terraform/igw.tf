# Create an AWS Internet Gateway resource
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id   # Attach the Internet Gateway to the specified VPC
}
