output "db_endpoint" {
  value = "${aws_db_instance.ex_database.endpoint}"
}

output "db_id" {
  value = "${aws_db_instance.ex_database.id}"
}
