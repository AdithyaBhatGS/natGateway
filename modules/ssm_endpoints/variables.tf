variable "vpc_id" {
  type        = string
  description = "Represents the VPC ID in which the Endpoints are created"
}

variable "endpoint_config" {
  type = map(object({
    service_name     = string
    subnet_ids       = list(string)
    security_grp_ids = list(string)
    tags             = map(string)
  }))

  description = "Contains the list of subnet IDs, security group IDs and the service name"
}

variable "region_name" {
  type        = string
  description = "Represents the region in which the endpoints are deployed"
}




