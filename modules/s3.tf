resource "aws_s3_bucket" "terraform_state" {
  bucket = "tf-state-bucket-devops-23"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}