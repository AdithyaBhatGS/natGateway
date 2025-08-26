output "nat_gateway_id" {
  value       = aws_nat_gateway.web_nat_gw.id
  description = "Represents the ID of the NAT Gateway"
}
