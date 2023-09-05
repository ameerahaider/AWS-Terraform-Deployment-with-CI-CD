data "aws_instances" "example" {
  instance_tags = {
    Name = "${var.name_prefix}-asg-instance"
  }
}

output "private_ips" {
  value = data.aws_instances.example.private_ips
}

output "test_output" {
  value = [for ip in data.aws_instances.example.private_ips : "${ip}"]
}