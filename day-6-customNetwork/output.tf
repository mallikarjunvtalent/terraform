output "vpc_id" {
  value       = aws_vpc.project-vpc.id
  description = "VPC ID of the project"
}

output "vpc_cidr_block" {
  value       = aws_vpc.project-vpc.cidr_block
  description = "VPC CIDR block"
}

output "public_subnet_id" {
  value       = aws_subnet.public-subnet.id
  description = "Public Subnet ID"
}

output "public_subnet_cidr" {
  value       = aws_subnet.public-subnet.cidr_block
  description = "Public Subnet CIDR"
}

output "private_subnet_id" {
  value       = aws_subnet.private-subnet.id
  description = "Private Subnet ID"
}

output "private_subnet_cidr" {
  value       = aws_subnet.private-subnet.cidr_block
  description = "Private Subnet CIDR"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.project-ig.id
  description = "Internet Gateway ID"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.project-ng.id
  description = "NAT Gateway ID"
}

output "route_table_public_id" {
  value       = aws_route_table.project-public-rt.id
  description = "Route Table ID for Public Subnet"
}

output "route_table_private_id" {
  value       = aws_route_table.project-private-rt.id
  description = "Route Table ID for Private Subnet"
}

output "route_table_public_association_id" {
  value       = aws_route_table_association.project-public.id
  description = "Route Table Association ID for Public Subnet"
}

output "route_table_private_association_id" {
  value       = aws_route_table_association.project-private.id
  description = "Route Table Association ID for Private Subnet"
}

output "security_group_id" {
  value       = aws_security_group.project-sg.id
  description = "Security Group ID"
}

output "public_instance_id" {
  value       = aws_instance.public-ec2.id
  description = "EC2 Instance ID in Public Subnet"
}

output "public_instance_public_ip" {
  value       = aws_instance.public-ec2.public_ip
  description = "Public IP of Public EC2"
}

output "private_instance_id" {
  value       = aws_instance.private-ec2.id
  description = "EC2 Instance ID in Private Subnet"
}

output "private_instance_private_ip" {
  value       = aws_instance.private-ec2.private_ip
  description = "Private IP of Private EC2"
}
