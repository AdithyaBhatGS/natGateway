variable "security_grps" {
  type = map(object({
    description = string
    tags        = map(string)
  }))

  description = "Represents the Group of Security Group Resource"
}

variable "vpc_id" {
  type        = string
  description = "Represents the VPC ID"
}

variable "ingress_rules" {
  type = map(object({
    cidr_ipv4      = string
    from_port      = number
    ip_protocol    = string
    to_port        = number
    security_group = string
  }))
  validation {
    condition = alltrue([for rules in values(var.ingress_rules) : contains(["public", "private", "ssm"], rules.security_group)])

    error_message = "The security_group attribute can only have public,private,ssm as its value"
  }
  description = "Represents the egress rules for the Security Group"
}

variable "egress_rules" {
  type = map(object({
    cidr_ipv4      = string
    from_port      = optional(number)
    ip_protocol    = string
    to_port        = optional(number)
    security_group = string
  }))
  validation {
    condition = alltrue([for rules in values(var.egress_rules) : contains(["public", "private", "ssm"], rules.security_group)])

    error_message = "The security_group attribute can only have public,private or ssm as its value"
  }
  description = "Represents the egress rules for the Security Group"
}
