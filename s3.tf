# S3バケットの定義
resource "aws_s3_bucket" "terraform_state" {
  # バケット名は一意の必要があるので、bucketの値は各自変更してください
  bucket = "opentofu-state-bucket"
}

# バージョニング設定
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}