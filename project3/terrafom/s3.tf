resource "aws_s3_bucket" "test_bucket" {
  bucket = "test-bucket-123-2024-12-28"

  tags = {
    Name        = "Test Bucket"
    Environment = "Development"
  }
}