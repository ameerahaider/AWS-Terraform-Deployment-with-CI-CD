output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "alb_target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.front_end.arn
}
