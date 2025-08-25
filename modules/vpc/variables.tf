variable "cidr_block" {
  type        = string
  description = "Specifies the cidr_block of the VPC resource"
}

variable "vpc_tags" {
  type        = map(string)
  description = "Specifies the tag associated to the VPC resource"
}
