variable "vpc_id" {
  type        = string
  description = "Represents the VPC ID"
}

variable "igw_tag" {
  type        = map(string)
  description = "Represents the tag attribute of the IGW resource"
}
