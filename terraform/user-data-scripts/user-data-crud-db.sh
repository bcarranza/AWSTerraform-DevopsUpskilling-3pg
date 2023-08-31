#!/bin/bash

yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
# Step 2 Change Hello World for Bonjour le monde
#mysql -u myrdsuser -p  -h localhost -P 3340
echo "Bonjour le monde from DB $(hostname -f)" > /var/www/html/index.html