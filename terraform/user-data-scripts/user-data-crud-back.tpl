#!/bin/bash
yum update -y
yum install -y telnet 

dnf update -y
dnf install -y mariadb105-server

yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
# Changed message.
echo "Bonjour le monde from Backend $(hostname -f)" > /var/www/html/index.html


