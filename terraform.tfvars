aws_region   = "us-east-1"
project_name = "terraform-aws-exercise"

# Networking Variables
# vpc with /16 gets 64k IPs
# subnets with /24 gets 256 IPs each
vpc_cidr     = "10.123.0.0/16"
public_cidrs = [
  "10.123.1.0/24",
  "10.123.2.0/24"
]
private_cidrs = [
  "10.123.101.0/24",
  "10.123.102.0/24"
]
accessip     = "0.0.0.0/0"

# Compute Variables
key_name             = "exercise_key"
public_key_path      = "/home/saul/.ssh/id_rsa.pub"
server_instance_type = "t2.micro"
instance_count       = 2
