module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                   = "my-s3-bucket-from-terraform"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    Enable = true
  }
}