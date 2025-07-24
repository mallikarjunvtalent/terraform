resource "aws_instance" "name-1" {
  ami           = "ami-0cbbe2c6a1bb2ad63"
   instance_type = "t3.micro"

  tags = {
    Name = "manual"
  }

  #  lifecycle {
  #   create_before_destroy = true
  # }
  # lifecycle {
  #   ignore_changes = [ tags ]
  # }
  lifecycle {
    prevent_destroy = true
  }
}

##terraform import aws_instance.name i-0a67de897a754c795
