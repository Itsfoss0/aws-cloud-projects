resource "aws_s3_bucket" "backend_storage" {
  bucket = var.s3_bucket_name
  tags   = var.s3_bucket_tags
}
