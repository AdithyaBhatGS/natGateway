resource "aws_subnet" "main" {
  for_each   = var.subnet_config
  vpc_id     = var.vpc_id
  cidr_block = each.value.cidr_block
  tags       = each.value.tags
}
