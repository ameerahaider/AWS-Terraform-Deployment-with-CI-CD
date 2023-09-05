variable "name_prefix" {
  description = "The prefix to use for all resource names"
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the instances"
  type        = string
}

variable "key_name" {
  description = "The key pair to use for the instances"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet for the jump server"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet for the database server"
  type        = string
}

variable "db_security_group_id" {
  description = "The ID of the security group for the instances"
  type        = string
}

variable "js_security_group_id" {
  description = "The ID of the security group for the instances"
  type        = string
}

variable "db_user_data" {
  description = "User data for instance configuration"
  type        = string
}