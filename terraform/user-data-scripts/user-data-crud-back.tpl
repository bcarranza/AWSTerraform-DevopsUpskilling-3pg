#!/bin/bash
yum update -y
yum install -y telnet # example telnet myrdsinstance.ciwxmuhfadid.us-east-1.rds.amazonaws.com 3306
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World from Backend $(hostname -f)" > /var/www/html/index.html





