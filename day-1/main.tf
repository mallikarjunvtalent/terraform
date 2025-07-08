resource "aws_instance" "name" {
  ami = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"
  key_name = "test"

}
resource "aws_s3_bucket" "name" {
  bucket = "mynewbucketfromterrafrom1111"
}
resource "aws_instance" "dev3" {
  ami = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"
  key_name = "test"
  tags = {
    name = "dev"
  }

}