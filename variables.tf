variable "aws_region" {}
variable "project_name" {}

# networking variables
variable "vpc_cidr" {}
variable "public_cidrs" {
  type = "list"
}
variable "private_cidrs" {
  type = "list"
}
variable "accessip" {}
