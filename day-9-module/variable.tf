variable "ami_id" {
  description = "inserting ami value into main"
  type = string
  default = ""
}
variable "instance_type" {
  type = string
  default = ""
}
variable "ec2_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = ""  # Optional: Remove default to enforce explicit value
}
variable "key" {
  type = string
  default = ""
}
variable "availability_zone" {
  type = string
  default = ""
}