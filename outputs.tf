
output "load_balancer_dns_name" {
  value = module.alb.alb_dns_name
}

output "jump_server_public_ip" {
  description = "Public IP of the jump server"
  value       = module.servers.jump_server_public_ip
}

output "private_ips" {
  description = "The public IP addresses of the instances in the autoscaling group"
  value       = module.autoscaling_group.test_output
}
