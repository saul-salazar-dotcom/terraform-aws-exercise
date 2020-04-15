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
