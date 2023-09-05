#!/bin/bash

# Update the system
sudo yum update -y

#Install Docker
sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
sudo systemctl enable docker

# Install required Python packages for Flask app
sudo yum install -y python3-pip
sudo pip3 install Flask itsdangerous Jinja2 MarkupSafe Werkzeug

# Install Apache web server and PHP 7
sudo amazon-linux-extras enable php7.4
sudo yum install -y httpd php php-mysqlnd

# Start the Apache service
sudo systemctl start httpd
sudo systemctl enable httpd

# Create the web root directory if not exists
sudo mkdir -p /var/www/html/index

# Create index.html file with embedded PHP
sudo bash -c "cat << 'EOF' > /var/www/html/index/index.php
<!DOCTYPE html>
<html>
<head>
  <title>My Web Page</title>
</head>
<body>
  <h1>Database Connection Test</h1>
  <?php
    \$servername = '${db_host}';
    \$username = '${db_username}';
    \$password = '${db_password}';
    \$dbname = '${db_name}';

    // Create connection
    \$conn = new mysqli(\$servername, \$username, \$password, \$dbname);

    // Check connection
    if (\$conn->connect_error) {
      die('Connection failed: ' . \$conn->connect_error);
    }
    echo 'Connected successfully';

    // Query to fetch data from users table
    \$sql = 'SELECT id, username FROM users';
    \$result = \$conn->query(\$sql);

    if (\$result->num_rows > 0) {
      // output data of each row
      while(\$row = \$result->fetch_assoc()) {
        echo 'id: ' . \$row['id']. ' - Name: ' . \$row['username']. '<br>';
      }
    } else {
      echo '0 results';
    }
    \$conn->close();
  ?>
</body>
</html>
EOF"

# Set permissions
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Restart Apache to apply changes
sudo systemctl restart httpd