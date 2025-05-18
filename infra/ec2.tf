provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "099720109477"  # Amazon Linux 2 などの AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "GitHubActionsEC22"
  }
}
