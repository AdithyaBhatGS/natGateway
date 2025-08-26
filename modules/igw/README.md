# Internet Gateway Module

## Description

This Terraform module creates an Internet Gateway. It outputs the Internet Gateway ID for use in dependent modules.

---

## Inputs

| Name    | Description                                        | Type        | Default | Required |
| ------- | -------------------------------------------------- | ----------- | ------- | -------- |
| vpc_id  | The VPC ID                                         | string      | n/a     | yes      |
| igw_tag | Map of strings containing tags of the igw resource | map(string) | n/a     | no       |

---

## Outputs

| Name   | Description                                     |
| ------ | ----------------------------------------------- |
| igw_id | The ID of the created Internet Gateway resource |

---

## Usage Example

---

```terraform

module "igw" {
    source  = "../modules/igw" # Adjust the path as needed
    vpc_id  = module.vpc.vpc_id # Id from the output of the VPC module
    igw_tag = {
        Name = "IGW_Web_backend"
        Environment = "dev"
    }
}

output "igw_id" {
    value       = aws_internet_gateway.web_igw.id
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
- Result: IGW created successfully with inputs as above.
- Next: Proceed to test the NAT Gateway module using outputs from VPC module, Subnets module and IGW module.
