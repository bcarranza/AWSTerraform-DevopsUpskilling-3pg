# Create an AWS Route Table resource for the VPC
resource "aws_route_table" "route" {
    vpc_id = aws_vpc.this.id   # Specify the ID of the VPC for which the route table is created

    route {
        cidr_block = "0.0.0.0/0"                                  # Route all traffic (0.0.0.0/0) to the internet gateway
        gateway_id = aws_internet_gateway.this.id                 # Use the ID of the internet gateway as the gateway ID
    }

    tags = {
        Name = "Route to internet"                                # Tag the route table with a descriptive name
    }
}

# Associate the public subnet 1 with the newly created route table
resource "aws_route_table_association" "rt1" {
    subnet_id      = aws_subnet.public-subnet-1.id               # Specify the ID of public subnet 1
    route_table_id = aws_route_table.route.id                    # Use the ID of the newly created route table
}

# Associate the public subnet 2 with the same route table
resource "aws_route_table_association" "rt2" {
    subnet_id      = aws_subnet.public-subnet-2.id               # Specify the ID of public subnet 2
    route_table_id = aws_route_table.route.id                    # Use the ID of the newly created route table
}
