provider "aws" {
  
}

resource "aws_instance" "ec2-2" {
  ami = "ami-05ffe3c48a9991133"
  instance_type = "t2.nano"
  key_name = "test"
  tags = {
    Name = "Ec2-3"
  }
}

