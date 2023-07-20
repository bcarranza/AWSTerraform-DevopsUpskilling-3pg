# Creating 1st EC2 instance in Private Subnet 1
resource "aws_instance" "ec2-private-1" {
  ami                         = "ami-007855ac798b5175e" #UBUNTU 22.04
  instance_type               = "t2.micro" #FREE TIER
  count                       = 1
  vpc_security_group_ids      = ["${aws_security_group.private.id}"]
  subnet_id                   = "${aws_subnet.private-subnet-1.id}"
  user_data                   = "${file("./user-data-scripts/user-data-crud-back.tpl")}"
  key_name                    = aws_key_pair.generated_key.key_name
  tags = {
    Name        = "${local.prefix}-ec2-private-1"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/ec2-private.tf"
  }
  depends_on = [
    aws_security_group.private,
    aws_subnet.private-subnet-1
  ]
}

# Creating 1st EC2 instance in Private Subnet 2
resource "aws_instance" "ec2-private-2" {
  ami                         = "ami-007855ac798b5175e" #UBUNTU 22.04
  instance_type               = "t2.micro" #FREE TIER
  count                       = 1
  vpc_security_group_ids      = ["${aws_security_group.private.id}"]
  subnet_id                   = "${aws_subnet.private-subnet-2.id}"
  user_data                   = data.template_file.db.rendered
  key_name                    = aws_key_pair.generated_key.key_name
  tags = {
    Name        = "${local.prefix}-ec2-private-2"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/ec2-private.tf"
  }
  depends_on = [
    aws_security_group.private,
    aws_subnet.private-subnet-2,
    aws_nat_gateway.nat,
    aws_route_table.private,
    aws_lb.internal-alb
  ]
}

data "template_file" "db" {
  template = file("${path.module}/user-data-scripts/user-data-crud-back.tpl")

  vars = {
    db_host  = aws_lb.internal-alb.dns_name
  }
}