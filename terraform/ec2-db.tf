# Creating 1st EC2 instance in Private Subnet 1
resource "aws_instance" "ec2-db-1" {
  ami                         = "ami-007855ac798b5175e" #UBUNTU 22.04
  instance_type               = "t2.micro" #FREE TIER
  count                       = 1
  vpc_security_group_ids      = ["${aws_security_group.db.id}"]
  subnet_id                   = "${aws_subnet.db-subnet-1.id}"
  user_data                   = "${file("./user-data-scripts/user-data-crud-db.sh")}"
  key_name                    = aws_key_pair.generated_key.key_name
  tags = {
    Name        = "${local.prefix}-ec2-db-1"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/ec2-db.tf"
  }
  depends_on = [
    aws_security_group.db,
    aws_subnet.db-subnet-1
  ]
}

# Creating 1st EC2 instance in Private Subnet 2
#resource "aws_instance" "ec2-db-2" {
#  ami                         = "ami-007855ac798b5175e" #UBUNTU 22.04
#  instance_type               = "t2.micro" #FREE TIER
#  count                       = 1
#  vpc_security_group_ids      = ["${aws_security_group.db.id}"]
#  subnet_id                   = "${aws_subnet.db-subnet-2.id}"
#  user_data                   = "${file("./user-data-scripts/user-data-crud-db.sh")}"
#  key_name                    = aws_key_pair.generated_key.key_name
#  tags = {
#    Name        = "${local.prefix}-ec2-db-2"
#    Environment = local.env
#    Path        = "${basename(abspath(path.module))}/ec2-db.tf"
#  }
#  depends_on = [
#    aws_security_group.db,
#    aws_subnet.db-subnet-2,
#    aws_nat_gateway.nat
#  ]
#}

