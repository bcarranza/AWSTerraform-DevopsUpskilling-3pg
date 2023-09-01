# Create an EC2 instance (Instance 1) in the private subnet 1
resource "aws_instance" "ec2-private-1" {
  ami                         = "ami-05548f9cecf47b442" # AMAZON LINUX 2
  instance_type               = "t2.micro"             # FREE TIER
  count                       = 1
  vpc_security_group_ids      = ["${aws_security_group.private.id}"]   # Attach security group for the instance
  subnet_id                   = "${aws_subnet.private-subnet-1.id}"    # Place the instance in private subnet 1
  user_data                   = "${file("./user-data-scripts/user-data-crud-back.tpl")}"   # User data script for instance configuration
  key_name                    = aws_key_pair.generated_key.key_name    # Key pair for SSH access
  disable_api_termination     = false
  tags = {
    Name        = "${local.prefix}-ec2-private-1"      # Name tag for identifying the instance
    Environment = local.env                            # Environment tag for categorization
    Path        = "${basename(abspath(path.module))}/ec2-private.tf"   # Path tag for tracking the configuration file
    Company = "3pg"                                    # Add new Tag to ec2
  }
  depends_on = [
    aws_security_group.private,              # Ensure security group is created before the instance
    aws_subnet.private-subnet-1              # Ensure private subnet 1 is created before the instance
  ]
}

# Create an EC2 instance (Instance 2) in the private subnet 2
resource "aws_instance" "ec2-private-2" {
  ami                         = "ami-05548f9cecf47b442" # AMAZON LINUX 2
  instance_type               = "t2.micro"             # FREE TIER
  count                       = 1
  vpc_security_group_ids      = ["${aws_security_group.private.id}"]   # Attach security group for the instance
  subnet_id                   = "${aws_subnet.private-subnet-2.id}"    # Place the instance in private subnet 2
  user_data                   = data.template_file.db.rendered         # User data script from the "data" block
  key_name                    = aws_key_pair.generated_key.key_name    # Key pair for SSH access
  disable_api_termination     = false
  tags = {
    Name        = "${local.prefix}-ec2-private-2"      # Name tag for identifying the instance
    Environment = local.env                            # Environment tag for categorization
    Path        = "${basename(abspath(path.module))}/ec2-private.tf"   # Path tag for tracking the configuration file
    Company = "3pg"                                    # Add new Tag to ec2
  }
  depends_on = [
    aws_security_group.private,              # Ensure security group is created before the instance
    aws_subnet.private-subnet-2,             # Ensure private subnet 2 is created before the instance
    aws_nat_gateway.nat,                     # Ensure NAT gateway is created before the instance
    aws_route_table.private,                 # Ensure private route table is created before the instance
    aws_lb.internal-alb                      # Ensure internal ALB is created before the instance
  ]
}

# Define a template file for the user data script, with variable 'db_host' set to the DNS name of the internal ALB
data "template_file" "db" {
  template = file("${path.module}/user-data-scripts/user-data-crud-back.tpl")

  vars = {
    db_host  = aws_lb.internal-alb.dns_name   # DNS name of the internal ALB to be used as a variable in the script
  }
}
