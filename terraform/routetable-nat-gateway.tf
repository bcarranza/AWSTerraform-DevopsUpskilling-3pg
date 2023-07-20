resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name        = "${local.prefix}-route_table-private"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/routetable-nat-gateway.tf"
  }
}


resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private.id
}

# Databases
resource "aws_route_table_association" "db-1" {
  subnet_id      = aws_subnet.db-subnet-1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db-2" {
  subnet_id      = aws_subnet.db-subnet-2.id
  route_table_id = aws_route_table.private.id
}