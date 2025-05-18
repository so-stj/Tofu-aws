terraform {
  required_providers {
    aws = {
      source = "opentofu/aws"
      version = "6.0.0-beta1"
    }
  }
}

provider "aws" {
    region = "us-east-1"
  # Configuration options
}