#!/bin/bash
yum install httpd -y
echo "Hola Osita!!! Subnets for Firewall: ${firewall_subnets}" >> /var/www/html/index.html
service httpd start
chkconfig httpd on