#! /bin/bash
sudo yum update
sudo yum -y install httpd
sudo service httpd start
#echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html