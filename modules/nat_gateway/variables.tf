variable "eip_tags" {
  type        = map(string)
  description = "Tags for EIP"
}

variable "subnet_id" {
  type        = string
  description = "Represents the Subnet ID in which NAT will be deployed"
}

variable "nat_tags" {
  type        = map(string)
  description = "Tags for NAT Gateway"
}
