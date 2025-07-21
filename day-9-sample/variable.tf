variable "ami_id" {
  description = "inserting ami value into main"
  type = string
  default = ""
}
variable "instance_type" {
  type = string
  default = "t2.medium"
}
variable "ec2_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "Ec2-1"  # Optional: Remove default to enforce explicit value
}