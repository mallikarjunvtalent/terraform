terraform {
  backend "s3" {
    bucket = "mybucket-for-terraform-remote-to-s3"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
