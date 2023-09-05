output "jump_server_public_ip" {
  description = "The public IP of the jump server"
  value       = aws_instance.jump_server.public_ip
}

output "db_host" {
  description = "The host of the database server"
  value       = aws_instance.database_server.private_ip
}
