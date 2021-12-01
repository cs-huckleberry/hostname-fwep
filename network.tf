resource "aws_network_interface" "eni0" {
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.allow_ssh.id]
}
resource "aws_network_interface" "eni1" {
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.allow_ssh.id]
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "fwep-test"
  }
}
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/23"
  instance_tenancy = "default"

  tags = {
    Name = "fwep-test"
  }
}
resource "aws_internet_gateway" "fwep_igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["76.92.213.54/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}