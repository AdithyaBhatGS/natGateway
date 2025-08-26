# NAT Gateway Module

## Description

This Terraform module creates a NAT Gateway. It outputs the NAT Gateway ID for use in dependent modules.

---

## Inputs

| Name      | Description                                          | Type        | Default | Required |
| --------- | ---------------------------------------------------- | ----------- | ------- | -------- |
| eip_tags  | The EIP tags                                         | map(string) | n/a     | no       |
| nat_tags  | The NAT Gateway tags                                 | map(string) | n/a     | no       |
| subnet_id | The Subnet ID in which NAT instance will be deployed | string      | n/a     | yes      |

---

## Outputs

| Name           | Description                                |
| -------------- | ------------------------------------------ |
| nat_gateway_id | The ID of the created NAT Gateway resource |

---

## Usage Example

---

```terraform

module "nat_gateway" {
    source     = "../modules/nat_gateway" # Adjust the path as needed
    nat_tags   = {
      Name = "Web-NAT Gateway"
      Environment = "dev"
    }
    eip_tags   = {
      Name = "NAT Eip"
      Environment = "dev"
    }
    subnet_id  = module.subnet.subnet_ids[var.public_subnet_name]

    depends_on = [module.igw]
}

output "igw_id" {
    value       = aws_nat_gateway.web_nat_gw.id
    description = "Represents the ID of the NAT Gateway"
}

```

## Testing

---

- Terraform version: v1.13.0
- AWS Region: us-east-1
- Steps:
  - Run `terraform init`
  - Run `terraform plan` and verify no errors
  - Run `terraform apply` and verify NAT Gateway in AWS console
- Result: NAT Gateway created successfully with inputs as above.
- Next: Proceed to test the Route tables module using outputs from VPC module, Subnets module and IGW module, NAT module.
