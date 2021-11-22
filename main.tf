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
  subnet_id     = aws_subnet.main.id
  key_name      = "ec2_oregon"

  user_data = <<EOF
    #cloud-config
       hostname = var.secondary_ip_addr
    
  EOF
  tags = {
    Name = "hostname-test"
  }
}
