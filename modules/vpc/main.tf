resource "aws_vpc" "web_backend" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = var.vpc_tags
}

