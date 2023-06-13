locals {
  env = "local"
}

resource "aws_s3_bucket" "this" {
  bucket = "my-test-bucket-novitskyi-1"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "this2" {
  bucket = "my-test-bucket-novitskyi-2"
  tags = {
    Name        = "My bucket"
    Environment = local.env
  }
}