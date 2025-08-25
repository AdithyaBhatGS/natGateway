output "igw_id" {
  description = "Returns the ID of IGW resource"
  value       = aws_internet_gateway.web_igw.id
}
