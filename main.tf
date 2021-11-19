terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "security"
  region  = "us-west-2"
}

resource "aws_instance" "fwep_server" {
  ami           = "ami-0142f6ace1c558c7d"
  instance_type = "t3.micro"

  tags = {
    Name = "hostname-test"
  }
}
