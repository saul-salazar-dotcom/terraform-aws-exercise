data "aws_availability_zones" "available" {}

resource "aws_vpc" "exercise_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "exercise_vpc"
  }
}

resource "aws_internet_gateway" "ex_internet_gateway" {
  vpc_id = "${aws_vpc.exercise_vpc.id}"

  tags {
    Name = "ex_igw"
  }
}

resource "aws_route_table" "ex_public_rt" {
  vpc_id = "${aws_vpc.exercise_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ex_internet_gateway.id}"
  }

  tags {
    Name = "ex_public"
  }
}

resource "aws_default_route_table" "ex_private_rt" {
  default_route_table_id  = "${aws_vpc.exercise_vpc.default_route_table_id}"

  tags {
    Name = "ex_private"
  }
}

resource "aws_subnet" "ex_public_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.exercise_vpc.id}"
  cidr_block              = "${var.public_cidrs[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "ex_public_${count.index + 1}"
  }
}

resource "aws_subnet" "ex_private_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.exercise_vpc.id}"
  cidr_block              = "${var.private_cidrs[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "ex_private_${count.index + 1}"
  }
}

resource "aws_route_table_association" "ex_public_assoc" {
  count          = "${aws_subnet.ex_public_subnet.count}"
  subnet_id      = "${aws_subnet.ex_public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.ex_public_rt.id}"
}

resource "aws_security_group" "ex_public_sg" {
  name        = "ex_public_sg"
  description = "Used for access to the public instances"
  vpc_id      = "${aws_vpc.exercise_vpc.id}"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.accessip}"]
  }
}

resource "aws_security_group" "ex_private_sg" {
  name        = "ex_private_sg"
  description = "Used for access to the private instances"
  vpc_id      = "${aws_vpc.exercise_vpc.id}"

  # MySQL
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = "${var.private_cidrs}"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.accessip}"]
  }
}
