variable "vpc_id" {
  type        = string
  description = "Represents VPC ID"
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
    tags       = map(string)
  }))
  description = "Contains the CIDR and tags for the subnet"
}
