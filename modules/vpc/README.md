# VPC Module

## Description

This Terraform module creates an AWS Virtual Private Cloud (VPC) with configurable CIDR block. It outputs the VPC ID for use in dependent modules.

---

## Inputs

| Name       | Description                     | Type        | Default | Required |
| ---------- | ------------------------------- | ----------- | ------- | -------- |
| cidr_block | The CIDR block for the VPC      | string      | n/a     | yes      |
| tags       | Map of tags to apply to the VPC | map(string) | n/a     | no       |

---

## Outputs

| Name   | Description               |
| ------ | ------------------------- |
| vpc_id | The ID of the created VPC |

---

## Usage Example

---

```terraform

module "vpc" {
    source = "../modules/vpc" # Adjust path as needed

    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "example-vpc"
        Environment = "dev"
    }
}

output "vpc_id" {
    value = module.vpc.vpc_id
}
```

## Testing

---

- Terraform version: v1.13.0
- AWS Region: us-east-1
- Steps:
  - Run `terraform init`
  - Run `terraform plan` and verify no errors
  - Run `terraform apply` and verify VPC in AWS console
- Result: VPC created successfully with inputs as above.
- Next: Proceed to test the Subnet module using outputs from this module.

## Notes

- Ensure CIDR block is a valid network base address (e.g., `10.0.0.0/16`).
- This module requires AWS provider configured.
