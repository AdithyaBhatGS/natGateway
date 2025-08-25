output "vpc_id" {
  value       = aws_vpc.web_backend.id
  description = "Contains the VPC ID"
}

# output "vpc_cidr" {
#   value       = aws_vpc.web_backend.cidr_block
#   description = "Contains the VPC CIDR "
# }
