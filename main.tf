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
  ami                    = "ami-0142f6ace1c558c7d"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.main.id
  key_name               = "ec2_oregon"
  vpc_security_group_ids = ["sg-0e99b28f6a4c1c99f"]
  
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.test.id
}

  user_data = <<EOF
    #!/bin/bash
    sudo hostnamectl set-hostname "${aws_network_interface.test.private_ips}"
    
  EOF
  tags = {
    Name = "hostname-test"
  }
}
