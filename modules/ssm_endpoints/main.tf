resource "aws_vpc_endpoint" "ssm_endpoint" {
  for_each            = var.endpoint_config
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region_name}.${each.value.service_name}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = each.value.subnet_ids
  security_group_ids  = each.value.security_grp_ids
  private_dns_enabled = true
  tags                = each.value.tags
}



