variable "env" {
  type = list(string)
  default = [ "dev-1","prod-1" ]
}

variable "ami_id" {
  type = string
  default = "ami-05ffe3c48a9991133"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}

resource "aws_instance" "name" {
  ami = var.ami_id
  instance_type = var.instance_type
   for_each = toset(var.env) #   count = length(var.env)  if it is count 
   tags = {
     Name = each.value  # for a set, each.value and each.key is the same
   }
}

