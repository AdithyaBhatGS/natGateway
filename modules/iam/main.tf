# Checking for existing IAM Role
data "aws_iam_role" "existing" {
  name = var.ec2_role_name
}

# Generating a Trust policy "AssumeRole" for EC2
data "aws_iam_policy_document" "trust_policy_for_ec2" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


# Attaching the Trust policy for the IAM Role
resource "aws_iam_role" "ec2_ssm_role" {
  count              = try(data.aws_iam_role.existing.name, null) == null ? 1 : 0
  name               = var.ec2_role_name
  assume_role_policy = data.aws_iam_policy_document.trust_policy_for_ec2.json
  description        = var.ec2_role_description
  tags               = var.ec2_role_tags
}

# Outputting the IAM Role name and ARN
locals {
  ssm_role_name = try(data.aws_iam_role.existing.name, aws_iam_role.ec2_ssm_role[0].name)
  ssm_role_arn  = try(data.aws_iam_role.existing.arn, aws_iam_role.ec2_ssm_role[0].arn)
}

# Attaching the managed policy for the IAM Role
resource "aws_iam_role_policy_attachment" "ssm_managed_policy" {
  role       = local.ssm_role_name
  policy_arn = var.ssm_policy_arn
}

# Creating an Instance profile for the EC2 resource
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = var.aws_iam_instance_profile
  role = local.ssm_role_name
}

