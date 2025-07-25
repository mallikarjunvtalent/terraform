resource "aws_instance" "ec2-1" {
  ami = var.ami_id
  instance_type = var.instance_type
  # key_name = "test"
  tags = {
    Name = "test3"
  }
}
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "name2" {
  cidr_block = "10.0.0.0/24"
}

# resource "aws_instance" "ec2-2" {
#   ami = var.ami_id
#   instance_type = var.instance_type
#   key_name = "test"
#   tags = {
#     Name = "Ec2-2"
#   }
# }