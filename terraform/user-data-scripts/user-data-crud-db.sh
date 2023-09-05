#!/bin/bash

yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Bonjour le monde from DB $(hostname -f)" > /var/www/html/index.html # change requested for lab03


