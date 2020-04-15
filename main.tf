provider "aws" {
  region = "${var.aws_region}"
}

# Deploy Network Resources
module "networking" {
  source        = "./networking"
  vpc_cidr      = "${var.vpc_cidr}"
  public_cidrs  = "${var.public_cidrs}"
  private_cidrs = "${var.private_cidrs}"
  accessip      = "${var.accessip}"
}

# Deploy EC2 Resources
module "compute" {
  source       = "./compute"
  instance_count  = "${var.instance_count}"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  instance_type   = "${var.server_instance_type}"
  subnets         = "${module.networking.public_subnets}"
  security_group  = "${module.networking.public_sg}"
  subnet_ips      = "${module.networking.public_ips}"
}

# Deploy RDS Resources
module "database" {
  source         = "./database"
  db_name        = "${var.db_name}"
  db_username    = "${var.db_username}"
  db_password    = "${var.db_password}"
  db_subnet      = "${module.networking.private_subnets}"
  security_group = "${module.networking.private_sg}"
}
