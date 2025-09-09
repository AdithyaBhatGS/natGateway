resource "aws_vpc" "web_backend" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = var.vpc_tags
  # Resolve the domains like com.amazonaws.region.ssm to IPs
  enable_dns_support = true
  # Assigns the IPs and hostnames for the devices within VPC
  enable_dns_hostnames = true
}

