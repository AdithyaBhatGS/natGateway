# EC2 module

## Description

This Terraform module creates an Instance. It outputs the Instance ID for testing the NAT Gateway.

---

## Inputs

| Name                 | Description                                        | Type         | Default | Required |
| -------------------- | -------------------------------------------------- | ------------ | ------- | -------- |
| subnet_id            | The Subnet ID                                      | string       | n/a     | yes      |
| security_groups      | List of strings containing security groups         | list(string) | n/a     | yes      |
| instance_type        | String containing the instance type                | string       | n/a     | yes      |
| ami                  | String representing the ami                        | string       | n/a     | yes      |
| iam_instance_profile | String representing the IAM Instance Profile       | string       | n/a     | yes      |
| tags                 | Map of strings containing tags of the EC2 resource | map(string)  | n/a     | no       |

---

## Outputs

| Name          | Description                        |
| ------------- | ---------------------------------- |
| instance_data | The ID of the created EC2 instance |

---

## Usage Example

---

```terraform

module "ec2" {
  source               = "../modules/ec2"
  subnet_id            = local.private_subnet_id
  security_groups      = [module.security_groups.security_group_ids[var.key_for_sg]]
  instance_type        = var.instance_type
  iam_instance_profile = module.iam.aws_ec2_instance_profile_arn
  tags                 = var.ec2_instance_tags
}

output "instance_data" {
  value       = aws_instance.private_instance.id
  description = "Represents the Instance ID of the deployed instance"
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
- Result: EC2 created successfully with inputs as above.
- Next: Go to the sessions manager in AWS Management Console and connect to the instance and check wheather the NAT Gateway is working properly or not
