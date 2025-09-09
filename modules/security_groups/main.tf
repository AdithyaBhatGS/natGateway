resource "aws_security_group" "sg_private_public" {
  for_each    = var.security_grps
  name        = each.key
  description = each.value.description
  vpc_id      = var.vpc_id

  tags = each.value.tags
}


resource "aws_vpc_security_group_ingress_rule" "ingress_rules" {
  for_each = var.ingress_rules


  security_group_id = aws_security_group.sg_private_public[each.value.security_group].id

  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "egress_rules" {
  for_each = var.egress_rules

  security_group_id = aws_security_group.sg_private_public[each.value.security_group].id

  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port
}



