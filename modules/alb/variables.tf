variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "name_prefix" {
  description = "The prefix to use for all resource names"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group for the load balancer"
  type        = string
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets for the load balancer"
  type        = list(string)
}
