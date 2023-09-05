output "js_SG" {
  description = "The ID of the Jump Server SG"
  value       = aws_security_group.js-sg.id
}

output "app_SG" {
  description = "The ID of the Application Server SG"
  value       = aws_security_group.app-sg.id
}

output "alb_SG" {
  description = "The ID of the Application Load Balancer SG"
  value       = aws_security_group.alb-sg.id
}

output "db_SG" {
  description = "The ID of the Database Server SG"
  value       = aws_security_group.db-sg.id
}