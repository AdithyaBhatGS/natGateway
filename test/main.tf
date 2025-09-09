provider "aws" {
  region                   = var.region
  shared_credentials_files = ["C:/Users/adithya.bhat/.aws/credentials"]
}

locals {
  # Retrieving the subnet_ids of public and private subnet and converting them into a list
  public_subnet_id   = module.subnet.subnet_ids["public_subnet"]
  private_subnet_id  = module.subnet.subnet_ids["private_subnet"]
  list_of_subnet_ids = tolist([local.public_subnet_id, local.private_subnet_id])
}

locals {
  # Retrieving the rt names 
  route_table_public  = var.web_rt[0]
  route_table_private = var.web_rt[1]
}

locals {
  # Creating individual routes(map(objects))

  individual_routes = {

    (local.route_table_public) = {
      route_table = local.route_table_public
      cidr_block  = var.dest_cidr_for_rt
      gateway_id  = module.igw.igw_id
    }

    (local.route_table_private) = {
      route_table    = local.route_table_private
      cidr_block     = var.dest_cidr_for_rt
      nat_gateway_id = module.nat_gateway.nat_gateway_id
    }

  }
}


locals {
  # Merging the security group associated with ssm with other ones
  # Reason to use locals for this is that ssm_inbound has a different cidr
  ingress_rules = merge(var.ingress_rules,
    {
      ssm_inbound = {
        cidr_ipv4      = module.vpc.vpc_cidr
        from_port      = var.from_port_ssm
        ip_protocol    = var.ssm_ip_protocol
        to_port        = var.to_port_ssm
        security_group = var.security_grp_ssm
      }
    }
  )

  egress_rules = merge(var.egress_rules,
    {
      private_outbound = {
        cidr_ipv4      = module.vpc.vpc_cidr
        from_port      = var.from_port_private_subnet_ssm_initiator
        ip_protocol    = var.ip_protocol_private_subnet_ssm_initiator
        to_port        = var.to_port_private_subnet_ssm_initiator
        security_group = var.security_grp_private_subnet_ssm_initiator
      }
    }
  )
}


locals {
  endpoint_config = {
    for service in var.endpoint_config_keys : service => {
      service_name     = service
      subnet_ids       = tolist([(local.private_subnet_id)])
      security_grp_ids = [module.security_groups.security_group_ids[var.security_grp_ssm]]
      tags             = merge(var.environment_tag, { Name = service })
    }
  }
}

# Calling the VPC Module
module "vpc" {
  source     = "../modules/vpc"
  cidr_block = var.vpc_cidr_block
  vpc_tags   = var.vpc_tags
}


# Calling the Subnet Module
module "subnet" {
  source        = "../modules/subnet"
  vpc_id        = module.vpc.vpc_id
  subnet_config = var.subnet_config_main
}

# Calling the Internet Gateway Module
module "igw" {
  source  = "../modules/igw"
  vpc_id  = module.vpc.vpc_id
  igw_tag = var.igw_tag
}

# Calling the NAT Gateway Module
module "nat_gateway" {
  source    = "../modules/nat_gateway"
  nat_tags  = var.nat_tags
  eip_tags  = var.eip_tags
  subnet_id = module.subnet.subnet_ids[var.public_subnet_name]
  # depends_on = [module.igw]
}

# Calling the Route Table Module
module "rt" {
  source = "../modules/rt"
  vpc_id = module.vpc.vpc_id

  route_tables    = zipmap(var.web_rt, local.list_of_subnet_ids)
  environment_tag = var.rt_tag
  routes          = local.individual_routes
  # depends_on      = [module.nat_gateway, module.igw]
}


# Calling the Security Group Module
module "security_groups" {
  source        = "../modules/security_groups"
  vpc_id        = module.vpc.vpc_id
  security_grps = var.security_group
  ingress_rules = local.ingress_rules
  egress_rules  = local.egress_rules
  # depends_on    = [module.igw, module.nat_gateway]
}

module "ssm_endpoints" {
  source          = "../modules/ssm_endpoints"
  vpc_id          = module.vpc.vpc_id
  endpoint_config = local.endpoint_config
  region_name     = var.region
}

module "iam" {
  source                   = "../modules/iam"
  ec2_role_name            = var.ec2_role_name
  ec2_role_description     = var.ec2_role_description
  ec2_role_tags            = var.ec2_role_tags
  ssm_policy_arn           = var.ssm_policy_arn
  aws_iam_instance_profile = var.aws_iam_instance_profile
}

module "ec2" {
  source               = "../modules/ec2"
  subnet_id            = local.private_subnet_id
  security_groups      = [module.security_groups.security_group_ids[var.key_for_sg]]
  instance_type        = var.instance_type
  iam_instance_profile = module.iam.aws_ec2_instance_profile_arn
  tags                 = var.ec2_instance_tags
}


