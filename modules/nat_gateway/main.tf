resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags   = var.eip_tags
}

resource "aws_nat_gateway" "web_nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.subnet_id
  tags          = var.nat_tags
}
