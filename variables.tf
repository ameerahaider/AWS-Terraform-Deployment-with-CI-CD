variable "region" {
  description = "The region where to deploy the infrastructure"
  type = string
  default = "us-east-1"
}

variable "availability_zones" {
  description = "List of availability zones for subnet association"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ami_id" {
  description = "AMI of Linux 2"
  type        = string
  default     = "ami-04823729c75214919"
}

variable "key_name" {
  description = "Key Pair Name"
  type        = string
  default     = "my-key-pair"
}

variable "name_prefix" {
  description = "The prefix to use for all resource names"
  type = string
  default = "Ameera"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type = string
  default = "192.168.16.0/20"
}

variable "public_subnets" {
  description = "The CIDR blocks for the public subnets"
  type = list(string)
  default = ["192.168.16.0/24", "192.168.17.0/24"]
}

variable "private_subnets" {
  description = "The CIDR blocks for the private subnets"
  type = list(string)
  default = ["192.168.18.0/24", "192.168.19.0/24", "192.168.20.0/24"]
}

variable "db_subnets" {
  description = "The CIDR block for the database subnet"
  type = list(string)
  default = ["192.168.21.0/24"]
}

variable "db_name" {
  description = "WordPress database name"
  type        = string
  default = "mydb"
}

variable "db_username" {
  description = "WordPress database username"
  type        = string
  default = "ameera"
}

variable "db_password" {
  description = "WordPress database password"
  type        = string
  default = "12345"
}


