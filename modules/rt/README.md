# NAT Gateway Module

## Description

This Terraform module creates 2 Route Tables. 1 for Public Subnet and the another for the Private Subnet.

---

## Inputs

| Name            | Description                                                                 | Type             | Default | Required |
| --------------- | --------------------------------------------------------------------------- | ---------------- | ------- | -------- |
| vpc_id          | The VPC ID                                                                  | string           | n/a     | yes      |
| route_tables    | Route table names and Corresponding Subnet IDs                              | map(string)      | n/a     | yes      |
| environment_tag | The tag representing the environment in which Route Table is being deployed | optional(string) | n/a     | no       |
| routes          | Route table names and corresponding route configurations                    | map(objects)     | n/a     | yes      |

---

## Usage Example

---

```terraform

module "rt" {
  source = "../modules/rt"
  vpc_id = module.vpc.vpc_id

  route_tables    = zipmap(var.web_rt, local.list_of_subnet_ids)
  environment_tag = var.rt_tag
  routes          = local.individual_routes
  depends_on      = [module.nat_gateway, module.igw]
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
- Result: Route tables are created successfully with inputs as above.
- Next: Proceed to test the EC2 module using outputs from VPC module, Subnets module and IGW module, NAT module and Route Table module.
