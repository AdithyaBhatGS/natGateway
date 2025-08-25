# Subnet Module

## Description

This Terraform module creates two Subnets with configurable CIDR block. It outputs the Subnet IDs for use in dependent modules.

---

## Inputs

| Name          | Description                                                          | Type         | Default | Required |
| ------------- | -------------------------------------------------------------------- | ------------ | ------- | -------- |
| vpc_id        | The VPC ID                                                           | string       | n/a     | yes      |
| subnet_config | Map of objects containing cidr_block and tags of the subnet resource | map(objects) | n/a     | yes      |

---

## Outputs

| Name       | Description                    |
| ---------- | ------------------------------ |
| subnet_ids | The IDs of the created Subnets |

---

## Usage Example

---

```terraform

module "subnet" {

    source        = "../modules/subnet" # Adjust the path as needed

    vpc_id        = module.vpc.vpc_id # Id from the output of the VPC module

    subnet_config = {

        public_subnet = {
            cidr_block = "10.0.1.0/24"

            tags = {
                Name = "public_subnet"
                Environment = "dev"
            }
        }

        private_subnet = {
            cidr_block = "10.0.2.0/24"
            tags = {
                Name = "private_subnet"
                Environment = "dev"
            }
        }
    }
}

output "subnet_ids" {
    description = "Returns the map of subnet ids"
    value       = { for key, subnet_obj in aws_subnet.main : key => subnet_obj.id }
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
- Result: Subnets created successfully with inputs as above.
- Next: Proceed to test the Internet Gateway module using outputs from VPC module.

## Notes

- Ensure CIDR block is a valid network base address (e.g., `10.0.1.0/24`).
- This module requires AWS provider configured.
