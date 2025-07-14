resource "aws_vpc" "project-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "project-project"
  }
}
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.project-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "project-public"
  }
}
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.project-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "project-private"
  }
}
resource "aws_internet_gateway" "project-ig" {
  vpc_id = aws_vpc.project-vpc.id
  tags = {
    Name = "project-ig"
  }
}
resource "aws_eip" "project-eip" {
  tags = {
    Name = "nat-eip"
  }
}
resource "aws_nat_gateway" "project-ng" {
  allocation_id = aws_eip.project-eip.id
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name = "project-ng"
  }
  depends_on = [aws_internet_gateway.project-ig]  # Make sure IGW exists before NAT is created
}
resource "aws_route_table" "project-private-rt" {
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.project-ng.id
  }
  tags = {
    Name ="project-private-rt"
  }
}
resource "aws_route_table_association" "project-private" {
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.project-private-rt.id
}
resource "aws_route_table" "project-public-rt" {
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-ig.id
  }
  tags = {
    Name ="project-public-rt"
  }
}
resource "aws_route_table_association" "project-public" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.project-public-rt.id
}
resource "aws_security_group" "project-sg" {
  name        = "project-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.project-vpc.id
    # ✅ Inbound Rules
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Caution: open to the world
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ✅ Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "project-sg"
  }
}
resource "aws_instance" "public-ec2" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [ aws_security_group.project-sg.id ]
  key_name = "test"
  associate_public_ip_address = true
  tags = {
    Name = "public-ec2"
  }
}
resource "aws_instance" "private-ec2" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private-subnet.id
  vpc_security_group_ids = [ aws_security_group.project-sg.id ]
  key_name = "test"
  tags = {
    Name = "private-ec2"
  }
}
