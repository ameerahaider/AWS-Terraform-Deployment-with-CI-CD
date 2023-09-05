#!/bin/bash

# Update the system
sudo yum update -y

# Install Docker
sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
sudo systemctl enable docker

# Install required Python packages for Flask app
sudo yum install -y python3-pip

# Install Python 3.8 and pip for Dockerfile
sudo amazon-linux-extras enable python3.8
sudo yum install -y python3.8
sudo python3.8 -m ensurepip --upgrade
sudo pip3.8 install --upgrade pip

# Install Apache HTTP Server (httpd)
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Create the directory for the test.html file
sudo mkdir -p /var/www/html

# Create the test.html file for health check
echo "Health check passed" | sudo tee /var/www/html/test.html
