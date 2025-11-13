# Represents the ARN of Instance profile
output "aws_ec2_instance_profile_name" {
  value = local.ssm_instance_profile_name
  # aws_iam_instance_profile.ec2_instance_profile.name
  description = "The name of the Instance Profile containing the IAM role for the EC2 instance"
}
