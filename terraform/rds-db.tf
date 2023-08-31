#create a RDS Database Instance
resource "aws_db_instance" "myinstance" {
  engine               = "mysql"
  identifier           = "myrdsinstance"
  allocated_storage    =  20
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "myrdsuser"
  password             = "myrdspassword"
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = ["${aws_security_group.db.id}"]
  skip_final_snapshot  = true
  publicly_accessible =  false
  db_subnet_group_name = aws_db_subnet_group.db.name   
  port = 3340   # change default port for database
}

#Testing
# Telnet: telnet myrdsinstance.ciwxmuhfadid.us-east-1.rds.amazonaws.com 3306
# Mysql:  mysql -u myrdsuser -p  -h myrdsinstance.ciwxmuhfadid.us-east-1.rds.amazonaws.com -P 3306

