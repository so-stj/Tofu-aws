# S3バケットの定義
resource "aws_s3_bucket" "terraform_state" {
  # バケット名は一意の必要があるので、bucketの値は各自変更してください
  bucket = "tf-state-bucket-devops-23"
}

# バージョニング設定
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

 backend "s3" {
   bucket = "tf-state-bucket-devops-23" # 作成したS3バケット
   region = "us-east-1"
   # バケット内の保存先
   # 適宜変更してください
   key = "test/terraform.tfstate"
   encrypt = true
 }