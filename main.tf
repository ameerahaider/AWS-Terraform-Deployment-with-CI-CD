provider "aws" {
    region = var.region
    access_key = "AKIAWGCDKTVXQHIGLZMO"
    secret_key = "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"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  name_prefix = var.name_prefix
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  db_subnets = var.db_subnets
  availability_zones = var.availability_zones
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  name_prefix = var.name_prefix
}

//Database Server User Data
data "template_file" "db_userdata" {
  template = file("./db-userdata.sh")

  vars = {
    db_name = "mydb"
    db_username = "ameera"
    db_password = "12345"
  }
}

//Server
module "servers" {
  source = "./modules/servers"
  ami_id = var.ami_id
  key_name = var.key_name
  public_subnet_id = module.vpc.public_subnets[0]
  private_subnet_id = module.vpc.db_subnets[0]
  js_security_group_id = module.sg.js_SG
  db_security_group_id = module.sg.db_SG

  db_user_data   = data.template_file.db_userdata.rendered
  name_prefix = var.name_prefix
}

//ALB
module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  security_group_id = module.sg.alb_SG
  public_subnet_ids = module.vpc.public_subnets
  name_prefix = var.name_prefix
}

//Auto Scaling Group
data "template_file" "wordpress_userdata" {
  template = file("./app_userdata.sh")

  vars = {
    db_name = "mydb"
    db_username = "ameera"
    db_password = "12345"
    db_host = module.servers.db_host
    alb_dns_name      = module.alb.alb_dns_name

  }
}

module "autoscaling_group" {
  source               = "./modules/autoscaling_group"
  name_prefix          = var.name_prefix
  ami_id               = var.ami_id
  instance_type        = "t2.micro"
  key_name             = var.key_name
  min_size             = 0

  max_size             = 5
  desired_capacity     = 1
  target_group_arns    = [module.alb.alb_target_group_arn]
  security_group_id    = module.sg.app_SG
  private_subnet_ids   = module.vpc.private_subnets
  user_data            = data.template_file.wordpress_userdata.rendered
}