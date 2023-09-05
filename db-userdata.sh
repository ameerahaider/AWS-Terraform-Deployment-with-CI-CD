#!/bin/bash

# Update the system
sudo yum update -y

# Install MariaDB server
sudo amazon-linux-extras enable mariadb10.5
sudo yum install -y mariadb-server

# Start MariaDB service
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Configure MariaDB to listen on all IP addresses
sudo sed -i '/bind-address/c\bind-address = 0.0.0.0' /etc/my.cnf

# Restart MariaDB service to apply changes
sudo systemctl restart mariadb

# Create a database, user, and table for the web application
sudo mysql -u root<<EOF
CREATE DATABASE ${db_name};
CREATE USER '${db_username}'@'%' IDENTIFIED BY '${db_password}';
GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_username}'@'%';
CREATE TABLE ${db_name}.users (id INT, username VARCHAR(255));
FLUSH PRIVILEGES;
exit;
EOF

# Restart MariaDB service to apply changes
sudo systemctl restart mariadb

