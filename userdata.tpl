#!/usr/bin/env bash

# Update Packages
sudo yum update -y
sudo yum upgrade -y

# Install Packages
sudo yum install curl wget -y

# Download VestaCP Installer
sudo curl -O http://vestacp.com/pub/vst-install.sh

# Install VestaCP with Random Password
sudo bash vst-install.sh --nginx yes --apache yes --phpfpm no --named yes --remi yes --vsftpd yes --proftpd no --iptables yes --fail2ban yes --quota no --exim yes --dovecot yes --spamassassin yes --clamav yes --softaculous yes --mysql yes --postgresql no --hostname cp01.test.com --email vantz@elitepconline.com --password $${random_password.password} --interactive no

# Write Admin Pass to file
sudo echo admin password: $${random_password.password} > /root/adminpass.txt