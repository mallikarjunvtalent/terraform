module "git-source" {
  source = "github.com/mallikarjunvtalent/terraform/day-9-module"
  ami_id = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"
  ec2_name = "Dev-Server-1"
  availability_zone = "us-east-1a"
}