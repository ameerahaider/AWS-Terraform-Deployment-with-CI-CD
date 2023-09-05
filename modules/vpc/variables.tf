variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "name_prefix" {
  description = "The prefix to use for all resource names"
  type = string
}

variable "availability_zones" {
  description = "List of availability zones for subnet association"
  type        = list(string)
}

variable "public_subnets" {
  description = "The CIDR blocks for the public subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "The CIDR blocks for the private subnets"
  type = list(string)
}

variable "db_subnets" {
  description = "The CIDR block for the database subnet"
  type = list(string)
}
