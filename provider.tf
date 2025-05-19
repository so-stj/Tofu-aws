terraform {
  required_providers {
    aws = {
      source = "opentofu/aws"
      version = "6.0.0-beta1"
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
}

provider "aws" {
  region = "us-east-1"
}
