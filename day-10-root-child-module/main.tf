module "vpc" {
  source         = "./modules/vpc"
  name           = var.vpc_name
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  azs            = var.azs
}

resource "aws_security_group" "app_sg" {
  name   = "app-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ec2" {
  source            = "./modules/ec2"
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = module.vpc.subnet_ids[0]
  security_group_id = aws_security_group.app_sg.id
  name              = var.ec2_name
}

module "rds" {
  source            = "./modules/rds"
  name              = var.rds_name
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password
  subnet_ids        = module.vpc.subnet_ids
  security_group_id = aws_security_group.app_sg.id
}
