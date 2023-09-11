#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
# Apache site message changed from Hello World to Bonjour le monde
echo "Bonjour le monde from Frontend $(hostname -f)" > /var/www/html/index.html
