variable "subnet_id" {
  type        = string
  description = "The Subnet in which the instance will be placed"
}

variable "security_groups" {
  type        = list(string)
  description = "Contains the list of security groups"
}

variable "instance_type" {
  type        = string
  description = "Describes the type of the instance which will be deployed"
}

variable "iam_instance_profile" {
  type        = string
  description = "Represents the instance profile to be attached to the current instance"
}

variable "tags" {
  type        = map(string)
  description = "Represents the tag associated to the EC2 resource"
}

