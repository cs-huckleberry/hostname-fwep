resource "aws_network_interface" "test" {
  subnet_id = aws_subnet.main.id
  #private_ips     = ["10.0.0.50"]

  attachment {
    instance     = aws_instance.fwep_server.id
    device_index = 1
  }
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