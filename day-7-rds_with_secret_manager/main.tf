
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
  name = "mycustsubnetwithsecret"
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

# --------------------
# Random password (secure)
# --------------------
resource "random_password" "rds_password" {
  length  = 16
  special = true
}

# Step 4: Create the RDS instance using secret values
resource "aws_db_instance" "my_rds" {
  identifier              = "my-rds-instance-with-secret"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  db_name                 = "myappdb2"
  username                = "admin"
  password                = random_password.rds_password.result
  db_subnet_group_name    = aws_db_subnet_group.sub_grp.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  parameter_group_name    = "default.mysql8.0"
  backup_retention_period  = 7   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Enable performance insights
#   performance_insights_enabled          = true
#   performance_insights_retention_period = 7  # Retain insights for 7 days
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)
  deletion_protection = true
  skip_final_snapshot = true
  depends_on              = [aws_db_subnet_group.sub_grp]
}

# --------------------
# Secrets Manager (write AFTER RDS is ready)
# --------------------
resource "aws_secretsmanager_secret" "rds_secret" {
  name = "rdsecrets" # your manual secret name
}
resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id

  secret_string = jsonencode({
    engine   = "mysql"
    host     = aws_db_instance.my_rds.address
    port     = 3306
    username = "admin"
    password = random_password.rds_password.result
    dbname   = "myappdb2"
  })

  depends_on = [aws_db_instance.my_rds]
}
