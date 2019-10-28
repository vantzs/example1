# tf-example1
 First Forray into Terraform

 ## What this does
 This code spins up a latest CentOS Minimal on AWS
 Installs updates and then installs VestaCP for webhosting
 Currently opening ports 80, 443, 22, and 8083 in the Security Group
 
 ### About VestaCP
 https://vestacp.com/
 VestaCP is a full blown and customizable webhosting stack
 This install provides the following components
 
 1. nginx + apache
 1. vsftpd
 1. exim + dovecot + spamassassin + clamav
 1. bind/named
 1. iptables + fail2ban
 1. softaculous
 1. Remi Repo
 1. MySQL
 1. no interactive install (will automatically install the control panel and all required components)
 