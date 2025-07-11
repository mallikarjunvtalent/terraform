output "ip" {
    value = aws_instance.ec2-1.public_ip
  
}
# output "privateip" {
#   value = aws_instance.ec2-2.private_ip
# }