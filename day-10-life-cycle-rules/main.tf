resource "aws_instance" "name" {
  ami = "ami-05ffe3c48a9991133"
  instance_type = "t2.medium"
 # key_name = "test"
#  tags = {
#    Name = "sit"
#  }

  lifecycle {
    create_before_destroy = true
  }
#   lifecycle {
#     ignore_changes = [ tags ]
#   }
#   lifecycle {
#     prevent_destroy = true
#   }
}