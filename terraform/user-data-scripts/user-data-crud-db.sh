#!/bin/bash

yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
#Change the apache site to response from Hello World to Bonjour le monde
echo "Bonjour le monde from DB $(hostname -f)" > /var/www/html/index.html


