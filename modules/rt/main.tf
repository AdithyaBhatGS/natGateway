resource "aws_route_table" "web_rt" {
  for_each = var.route_tables
  vpc_id   = var.vpc_id
  tags = {
    Name        = "${each.key}_route_table"
    Environment = var.environment_tag
  }
}

resource "aws_route" "web_routes" {
  for_each               = var.routes
  route_table_id         = aws_route_table.web_rt[each.value.route_table].id
  gateway_id             = each.value.gateway_id
  nat_gateway_id         = each.value.nat_gateway_id
  destination_cidr_block = each.value.cidr_block
}

resource "aws_route_table_association" "rt_subnet_map" {
  for_each       = var.route_tables
  subnet_id      = each.value
  route_table_id = aws_route_table.web_rt[each.key].id
}
