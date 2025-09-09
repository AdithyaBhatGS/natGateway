# Security Group Module

## Description

This Terraform module creates the required security groups for Instance in the Private Subnet as well as SSM Endpoints.

---

## Inputs

| Name          | Description                                             | Type        | Default | Required |
| ------------- | ------------------------------------------------------- | ----------- | ------- | -------- |
| security_grps | The object containing the description and tag attribute | map(object) | n/a     | yes      |
| vpc_id        | Represents the VPC ID                                   | string      | n/a     | yes      |
| ingress_rules | Map of object representing the inbound rules            | map(object) | n/a     | yes      |
| egress_rules  | Map of object representing the outbound rules           | map(object) | n/a     | yes      |

---

## Outputs

| Name               | Description                                                                        |
| ------------------ | ---------------------------------------------------------------------------------- |
| security_group_ids | The key => value pair, representing the name and id of the created security groups |

---

## Usage Example

---

```terraform

# Calling the Security Group Module
module "security_groups" {
  source        = "../modules/security_groups"
  vpc_id        = module.vpc.vpc_id
  security_grps = var.security_group
  ingress_rules = local.ingress_rules
  egress_rules  = local.egress_rules
  # depends_on    = [module.igw, module.nat_gateway]
}

output "security_group_ids" {
  description = "Outputs a Map containing the Security Group ID with the name of the Security Group"
  value       = { for sg, sg_obj in aws_security_group.sg_private_public : sg => sg_obj.id }
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
- Next: Use the output of the current module in order to create the ssm endpoints
