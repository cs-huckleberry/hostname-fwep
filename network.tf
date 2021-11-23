resource "aws_network_interface" "eni0" {
  subnet_id       = aws_subnet.main.id
  security_groups = ["sg-0e99b28f6a4c1c99f"]
}
resource "aws_network_interface" "eni1" {
  subnet_id       = aws_subnet.main.id
  security_groups = ["sg-0e99b28f6a4c1c99f"]
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