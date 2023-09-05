resource "aws_instance" "jump_server" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.js_security_group_id]
  associate_public_ip_address = true
  tags = {
    Name = "${var.name_prefix}-jump-server"
  }
}

resource "aws_instance" "database_server" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.db_security_group_id]
  user_data                   = var.db_user_data

  tags = {
    Name = "${var.name_prefix}-database-server"
  }
}
