output "security_group_ids" {
  description = "Outputs a Map containing the Security Group ID with the name of the Security Group"
  value       = { for sg, sg_obj in aws_security_group.sg_private_public : sg => sg_obj.id }
}
