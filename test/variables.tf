variable "region" {
  type    = string
  default = "us-east-1"
}


variable "vpc_cidr_block" {
  type        = string
  description = "Specifies the cidr_block of the VPC resource"
}

variable "vpc_tags" {
  type        = map(string)
  description = "Specifies the tag associated to the VPC resource"
}

variable "subnet_config_main" {
  type = map(object({
    cidr_block = string
    tags       = map(string)
  }))
  description = "Contains the CIDR and tags for the Subnet"
}

variable "igw_tag" {
  type        = map(string)
  description = "Contains the tag associated with the Internet Gateway resource"
}

variable "nat_tags" {
  type        = map(string)
  description = "Tags for NAT Gateway"
}

variable "eip_tags" {
  type        = map(string)
  description = "Tags for EIP"
}

variable "public_subnet_name" {
  type        = string
  description = "Name of the deployed Public Subnet"
}

variable "web_rt" {
  type        = list(string)
  description = "List of string names representing the Route Table names"
}


variable "rt_tag" {
  type        = string
  description = "Represents the tag associated with the Route Table resource"
}

variable "dest_cidr_for_rt" {
  type        = string
  description = "Destination to which the traffic will be routed from RT"
}

variable "security_group" {
  type = map(object({
    description = string
    tags        = map(string)
  }))

  description = "Represents the security group"
}

variable "ingress_rules" {
  type = map(object({
    cidr_ipv4      = string
    from_port      = number
    ip_protocol    = string
    to_port        = number
    security_group = string
  }))

  description = "Represents the ingress for the security group"
}

variable "egress_rules" {
  type = map(object({
    cidr_ipv4      = string
    from_port      = optional(number)
    ip_protocol    = string
    to_port        = optional(number)
    security_group = string
  }))

  description = "Represents the egress for the security group"
}

variable "from_port_ssm" {
  type        = number
  description = "Represents the from Port number for ssm inbound"
}

variable "to_port_ssm" {
  type        = number
  description = "Represents the to Port number for SSM inbound"
}

variable "ssm_ip_protocol" {
  type        = string
  description = "Represents the SSM IP Protocol for SSM inbound"
}

variable "security_grp_ssm" {
  type        = string
  description = "Represents the Security Group SSM Name for SSM inbound"
}

variable "from_port_private_subnet_ssm_initiator" {
  type        = number
  description = "Represent the from Port number for Private Subnet outbound for initiation the HTTPS"
}

variable "to_port_private_subnet_ssm_initiator" {
  type        = number
  description = "Represent the to Port number for Private Subnet outbound for initiation the HTTPS"
}

variable "ip_protocol_private_subnet_ssm_initiator" {
  type        = string
  description = "Represent the IP Protocol for Private Subnet outbound for initiation the HTTPS"
}

variable "security_grp_private_subnet_ssm_initiator" {
  type        = string
  description = "Represents the Security Group Private Subnet SSM Initiator Name for HTTPS outbound"
}


variable "endpoint_config_keys" {
  type        = list(string)
  description = "Represents a list containing the keys for endpoint_config"
}

variable "environment_tag" {
  type        = map(string)
  description = "Contains a key-value pair which represents the Environment in which the infrastructure will be deployed"
}

variable "ec2_role_name" {
  type        = string
  description = "Represents the name of the EC2 Role"
}

variable "ec2_role_description" {
  type        = string
  description = "Represents the description of the Role attached to the instance"
}

variable "ec2_role_tags" {
  type        = map(string)
  description = "Represents the tags attached to the Role attached to the instance"
}

variable "ssm_policy_arn" {
  type        = string
  description = "Represents the ARN for the SSM policy"
}

variable "aws_iam_instance_profile" {
  type        = string
  description = "Represents the Instance Profile attached to the EC2 resource"
}

variable "instance_type" {
  type        = string
  description = "Represents the instance type of the EC2 resource"
}

variable "ec2_instance_tags" {
  type        = map(string)
  description = "Represents the tags for the EC2 resource"
}

variable "key_for_sg" {
  type        = string
  description = "Represents the key for Security Group in which EC2 have to be deployed"
}
