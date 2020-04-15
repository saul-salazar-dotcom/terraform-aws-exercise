resource "aws_db_subnet_group" "ex_db-sg" {
  name       = "ex_db-subnet-group"
  subnet_ids = ["${var.db_subnet}"]
}

resource "aws_db_instance" "ex_database" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "${var.db_name}"
  username               = "${var.db_username}"
  password               = "${var.db_password}"
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = ["${var.security_group}"]
  db_subnet_group_name   = "${aws_db_subnet_group.ex_db-sg.name}"
}
