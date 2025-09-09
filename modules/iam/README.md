# IAM Module

## Description

This Terraform module creates an IAM Role with an instance profile which provides the SSM access to EC2. It outputs the Instance Profile Name which can be used in the dependent modules.

---

## Inputs

| Name                 | Description                                  | Type   | Default | Required |
| -------------------- | -------------------------------------------- | ------ | ------- | -------- |
| ec2_role_name        | The name of the role that is being created   | string | n/a     | yes      |
| ec2_role_description | Description of the role                      | string | n/a     | yes      |
| ec2_role_tags        | Map of strings containing tag for the Role   | string | n/a     | yes      |
| ssm_policy_arn       | String representing SSM Policy ARN           | string | n/a     | yes      |
| iam_instance_profile | String representing the IAM Instance Profile | string | n/a     | yes      |

---

## Outputs

| Name                          | Description                                   |
| ----------------------------- | --------------------------------------------- |
| aws_ec2_instance_profile_name | The name of the created instance profile name |

---

## Usage Example

---

```terraform

module "iam" {
  source                   = "../modules/iam"
  ec2_role_name            = var.ec2_role_name
  ec2_role_description     = var.ec2_role_description
  ec2_role_tags            = var.ec2_role_tags
  ssm_policy_arn           = var.ssm_policy_arn
  aws_iam_instance_profile = var.aws_iam_instance_profile
}

output "aws_ec2_instance_profile_name" {
  value       = aws_iam_instance_profile.ec2_instance_profile.name
  description = "The ARN of the Instance Profile containing the IAM role for the EC2 instance"
}


```

## Testing

---

- Terraform version: v1.13.0
- AWS Region: us-east-1
- Steps:
  - Run `terraform init`
  - Run `terraform plan` and verify no errors
  - Run `terraform apply` and verify IGW in AWS console
- Result: IAM created successfully with inputs as above.
- Next: Use the output of the current module and create the new module for deploying the EC2 instance
