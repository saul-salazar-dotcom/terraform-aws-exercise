output "public_subnets" {
  value = "${aws_subnet.ex_public_subnet.*.id}"
}

output "private_subnets" {
  value = "${aws_subnet.ex_private_subnet.*.id}"
}

output "public_sg" {
  value = "${aws_security_group.ex_public_sg.id}"
}

output "private_sg" {
  value = "${aws_security_group.ex_private_sg.id}"
}

output "public_ips" {
  value = "${aws_subnet.ex_public_subnet.*.cidr_block}"
}

output "private_ips" {
  value = "${aws_subnet.ex_private_subnet.*.cidr_block}"
}
