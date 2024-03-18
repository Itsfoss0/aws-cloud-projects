resource "aws_s3_bucket" "avatar_storage" {
    bucket = var.s3_bucket_name
    tags = var.s3_tags
    
}