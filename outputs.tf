# Networking Outputs

output "Public Subnets" {
  value = "${join(", ", module.networking.public_subnets)}"
}

output "Public Subnet IPs" {
  value = "${join(", ", module.networking.public_ips)}"
}

output "Public Security Group" {
  value = "${module.networking.public_sg}"
}

# Compute Outputs

output "Public Instance IDs" {
  value = "${module.compute.server_id}"
}

output "Public Instance IPs" {
  value = "${module.compute.server_ip}"
}

# Database Outputs
output "Database Endpoint" {
  value = "${module.database.db_endpoint}"
}

output "Database RDS ID" {
  value = "${module.database.db_id}"
}
