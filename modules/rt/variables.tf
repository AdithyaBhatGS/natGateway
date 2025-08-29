variable "vpc_id" {
  type        = string
  description = "Represents the VPC ID in which Route Table will be created"
}

variable "route_tables" {
  type        = map(string)
  description = "Represents the route table names and Subnet IDs to which they are mapped"
}

variable "environment_tag" {
  type        = optional(string)
  description = "Represents the Environment attribute under tag attribute in which the infrastructure is being deployed"
}

variable "routes" {
  type = map(object({
    route_table    = string
    cidr_block     = string
    gateway_id     = optional(string)
    nat_gateway_id = optional(string)
  }))
}


