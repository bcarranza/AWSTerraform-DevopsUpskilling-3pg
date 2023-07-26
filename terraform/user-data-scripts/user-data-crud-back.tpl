#!/bin/bash
yum update -y
yum install -y telnet 

dnf update -y
dnf install mariadb105-server

yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World from Backend $(hostname -f)" > /var/www/html/index.html


