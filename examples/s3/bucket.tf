resource "aws_s3_bucket" "name" {
  bucket = "dksahjdoiashdnoa"

  tags = {
    Name = "Example S3 Bucket"
  }
}

resource "aws_s3_bucket_versioning" "config" {
  bucket = aws_s3_bucket.name.id
  versioning_configuration {
    status = "Enabled"
  }
}
