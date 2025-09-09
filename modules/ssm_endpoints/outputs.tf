output "endpoint_ids" {
  value = { for service_name, endpoint in aws_vpc_endpoint.ssm_endpoint : service_name => endpoint.id }
}


