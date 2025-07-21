variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = []
}

variable "azs" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = []
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = ""
}

variable "ec2_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = ""
}

variable "rds_name" {
  description = "Name of the RDS instance"
  type        = string
  default     = ""
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = ""
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Master password for RDS"
  type        = string
   sensitive   = true
  default     = "" # Not secure for production!
}
