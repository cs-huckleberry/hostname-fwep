output "secondary_ip_addr" {
  value = aws_network_interface.test.private_ips
}