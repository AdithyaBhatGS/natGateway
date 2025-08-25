output "subnet_ids" {
  description = "Returns the map of subnet ids"
  value       = { for key, subnet_obj in aws_subnet.main : key => subnet_obj.id }
}
