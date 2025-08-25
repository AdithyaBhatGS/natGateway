resource "aws_internet_gateway" "web_igw" {
  vpc_id = var.vpc_id
  tags   = var.igw_tag
}
