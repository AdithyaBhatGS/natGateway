
resource "aws_instance" "private_instance" {
  subnet_id            = var.subnet_id
  security_groups      = var.security_groups
  instance_type        = var.instance_type
  ami                  = "ami-055744c75048d8296"
  iam_instance_profile = var.iam_instance_profile
  tags                 = var.tags
}
