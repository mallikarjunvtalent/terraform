vpc_name       = "my-vpc1"
vpc_cidr       = "10.0.0.0/16"
public_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
azs            = ["us-east-1a", "us-east-1b"]

ami            = "ami-05ffe3c48a9991133"
instance_type  = "t2.micro"
ec2_name       = "ec2-demo"

rds_name       = "my-rds-2"
db_name        = "appdb-2"
db_username    = "admin"
db_password    = "Terraform123!"
