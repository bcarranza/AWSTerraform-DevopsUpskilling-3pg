# When an EC2 instance in a private subnet needs to access the Internet, the traffic flow follows a specific path through the NAT Gateway and the public subnet. Here's the process explained:

# 1. Request from the EC2 instance: The EC2 instance in the private subnet sends a request to access a resource on the Internet. This request includes the private IP address of the instance as the source IP address.
# EC2 instance sends a request to access the Internet.
# private_ip = 'private IP address of the EC2 instance'

# 2. Routing through the private route table: The request is directed to the route table associated with the private subnet. This route table has a rule that routes traffic destined for the Internet (0.0.0.0/0) to the NAT Gateway.
# Route the request to the NAT Gateway for Internet access.
# private_route_table = 'private route table associated with the private subnet'
# destination = '0.0.0.0/0'
# next_hop = 'NAT Gateway'

# 3. Address translation at the NAT Gateway: When the request reaches the NAT Gateway in the public subnet, the NAT Gateway translates the private source IP address of the EC2 instance to its own public IP address (the NAT Gateway's IP address). This process is called Source Network Address Translation (SNAT).
# Perform Source NAT (SNAT) to translate the source IP address.
# public_ip = 'public IP address of the NAT Gateway'
# translated_source_ip = 'translate EC2 private IP to NAT Gateway public IP'

# 4. Request to the Internet: The request, now with the NAT Gateway's public IP address as the source IP, is sent to the Internet through the Internet Gateway associated with the VPC.
# Send the request to the Internet.
# internet_gateway = 'Internet Gateway associated with the VPC'

# 5. Response from the Internet: When the Internet resource sends a response, the destination IP address of the response is the public IP address of the NAT Gateway.
# Get the response from the Internet.
# destination_ip = 'public IP address of the NAT Gateway'

# 6. Reverse address translation at the NAT Gateway: The NAT Gateway translates the destination IP address in the response from its own public IP address to the original private IP address of the EC2 instance that sent the request. This process is called Destination Network Address Translation (DNAT).
# Perform Destination NAT (DNAT) to translate the destination IP address back to the original EC2 private IP.
# original_private_ip = 'translate NAT Gateway public IP to original EC2 private IP'

# 7. Delivery of the response to the EC2 instance: The response is sent back through the private route table and delivered to the EC2 instance in the private subnet using its private IP address.
# Deliver the response back to the EC2 instance in the private subnet.
# response = 'response from the Internet delivered to EC2 private IP in private subnet'


# Create an Elastic IP (EIP) resource for the NAT Gateway.
resource "aws_eip" "nat" {
  domain = "vpc"

  # Define tags for the Elastic IP resource.
  tags = {
    Name        = "${local.prefix}-nat-eip"    # Tag to name the Elastic IP based on the local prefix variable.
    Environment = local.env                     # Tag to specify the environment based on the local env variable.
    Path        = "${basename(abspath(path.module))}/nat-gateway.tf" # Tag to specify the file path for this resource.
  }
}

# Create a NAT Gateway resource.
resource "aws_nat_gateway" "nat" {
  subnet_id     = "${aws_subnet.public-subnet-1.id}" # Specify the ID of the public subnet where the NAT Gateway will be created.
  allocation_id = aws_eip.nat.id                     # Associate the Elastic IP created above with the NAT Gateway.

  # Define tags for the NAT Gateway resource.
  tags = {
    Name        = "${local.prefix}-nat-gateway"     # Tag to name the NAT Gateway based on the local prefix variable.
    Environment = local.env                         # Tag to specify the environment based on the local env variable.
    Path        = "${basename(abspath(path.module))}/nat-gateway.tf" # Tag to specify the file path for this resource.
  }
}

