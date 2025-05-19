terraform {
  required_providers {
    aws = {
      source = "opentofu/aws"
      version = "6.0.0-beta1"
    }
  }
   backend "s3" {
   bucket = "tf-state-bucket-devops-23"
   region = "us-east-1"
   key = "test/terraform.tfstate"
   encrypt = true
   dynamodb_table = "tf-locks"
 }
}

provider "aws" {
  region = "us-east-1"
}
