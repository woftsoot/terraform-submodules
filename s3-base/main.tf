provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_s3_bucket" "simple-bucket" {
  bucket = "${var.simple_bucket_name}"
  acl = "private"

  tags = {
    Name = "Simple Bucket"
  }
}
