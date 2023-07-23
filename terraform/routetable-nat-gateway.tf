# Create an AWS Route Table resource for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id   # Specify the ID of the VPC for which the route table is created

  route {
    cidr_block     = "0.0.0.0/0"                           # Route all traffic (0.0.0.0/0) to the NAT gateway
    nat_gateway_id = aws_nat_gateway.nat.id                 # Use the ID of the NAT gateway as the gateway ID
  }

  tags = {
    Name        = "${local.prefix}-route_table-private"    # Tag the route table with a descriptive name
    Environment = local.env                                 # Tag the route table with the environment
    Path        = "${basename(abspath(path.module))}/routetable-nat-gateway.tf"   # Tag the route table with the configuration file path
  }
}

# Associate private subnet 1 with the private route table
resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private-subnet-1.id           # Specify the ID of private subnet 1
  route_table_id = aws_route_table.private.id              # Use the ID of the private route table
}

# Associate private subnet 2 with the private route table
resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private-subnet-2.id           # Specify the ID of private subnet 2
  route_table_id = aws_route_table.private.id              # Use the ID of the private route table
}

# Associate database subnet 1 with the private route table
resource "aws_route_table_association" "db-1" {
  subnet_id      = aws_subnet.db-subnet-1.id                # Specify the ID of database subnet 1
  route_table_id = aws_route_table.private.id              # Use the ID of the private route table
}

# Associate database subnet 2 with the private route table
resource "aws_route_table_association" "db-2" {
  subnet_id      = aws_subnet.db-subnet-2.id                # Specify the ID of database subnet 2
  route_table_id = aws_route_table.private.id              # Use the ID of the private route table
}
