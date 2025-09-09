# SSM Endpoint Module

## Description

This Terraform module creates the SSM Endpoint.Here we would be creating 3 endpoints including ec2messages, ssmmessages, ssm. SSM Endpoints are essential to log in to the EC2 instance without the help of key pair. From this we can stop exposing the ports for login.

---

## Inputs

| Name            | Description                                                                         | Type        | Default | Required |
| --------------- | ----------------------------------------------------------------------------------- | ----------- | ------- | -------- |
| vpc_id          | Represents the VPC ID in which the Endpoints are deployed                           | string      | n/a     | yes      |
| endpoint_config | Represents the object containing service name, subnet ids, security groups and tags | map(object) | n/a     | yes      |
| region_name     | Represents the region name                                                          | map(object) | n/a     | yes      |

---

## Outputs

| Name         | Description                                                            |
| ------------ | ---------------------------------------------------------------------- |
| endpoint_ids | The key => value pair, representing the service names and endpoint ids |

---

## Usage Example

---

```terraform

# Calling the Security Group Module
module "ssm_endpoints" {
  source          = "../modules/ssm_endpoints"
  vpc_id          = module.vpc.vpc_id
  endpoint_config = local.endpoint_config
  region_name     = var.region
}

output "endpoint_ids" {
  value = { for service_name, endpoint in aws_vpc_endpoint.ssm_endpoint : service_name => endpoint.id }
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
- Next: Use the output of the current module in order to create the IAM module and EC2 instance module
