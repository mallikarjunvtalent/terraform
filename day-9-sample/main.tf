resource "aws_instance" "ec2-1" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = "test"
  tags = {
    Name = var.ec2_name
  }
}
# resource "aws_instance" "ec2-2" {
#   ami = var.ami_id
#   instance_type = var.instance_type
#   key_name = "test"
#   tags = {
#     Name = "Ec2-2"
#   }
# }