variable "allowed_ports" {
  type = map(string)
  default = {
    22    = "203.0.113.0/24"    # SSH (Restrict to office IP)
    80    = "0.0.0.0/0"         # HTTP (Public)
    443   = "0.0.0.0/0"         # HTTPS (Public)
    8080  = "10.0.0.0/16"       # Internal App (Restrict to VPC)
    9000  = "192.168.1.0/24"    # SonarQube/Jenkins (Restrict to VPN)
    3389  = "10.0.1.0/24"
  }
}

resource "aws_security_group" "devops-project-veera" {
  name        = "devops-project-veera"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description      = "Allow access to port ${ingress.key} inbound rules"
      from_port        = ingress.key
      to_port          = ingress.key
      protocol         = "tcp"
      cidr_blocks      = [ingress.value]
      ipv6_cidr_blocks = []
      prefix_list_ids  = [] 
      security_groups  = []
      self             = false
    }
  } 
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project-veera"
  }
}