output "instance_data" {
  value       = aws_instance.private_instance.id
  description = "Represents the Instance ID of the deployed instance"
}
