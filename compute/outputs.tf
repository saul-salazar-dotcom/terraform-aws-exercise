output "server_id" {
  value = "${join(", ", aws_instance.ex_server.*.id)}"
}

output "server_ip" {
  value = "${join(", ", aws_instance.ex_server.*.public_ip)}"
}
