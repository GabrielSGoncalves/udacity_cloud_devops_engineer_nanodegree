resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-855655753923-bucket"

  tags = {
    project = "s3 static website"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}