#!/bin/bash

yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
# Step 2 Change Hello World for Bonjour le monde
echo "Bonjour le monde from DB $(hostname -f)" > /var/www/html/index.html


