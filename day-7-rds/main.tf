
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev"
  }
}
resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-1"
  }
}
resource "aws_subnet" "subnet-2" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-2"
  }
}
resource "aws_db_subnet_group" "sub_grp" {
  name = "mycustsubnet"
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
 # provider = aws.primary 
  tags = {
    Name = "My DB subnet group"
  }
}

# Step 3: Create Security Group
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL traffic"
  vpc_id      = aws_vpc.name.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ Restrict in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Step 4: Create the RDS instance using secret values
resource "aws_db_instance" "my_rds" {
  identifier              = "my-rds-instance"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  db_name                 = "myappdb"
  username                = "admin"
  password                = "mysql123"
  db_subnet_group_name    = aws_db_subnet_group.sub_grp.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  depends_on              = [aws_db_subnet_group.sub_grp]
}
