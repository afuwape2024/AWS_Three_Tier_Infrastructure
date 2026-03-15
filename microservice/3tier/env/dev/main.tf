module "vpc" {
  source     = "../../modules/vpc-module"
  new_vpc    = local.vpc_name
  cidr_block = local.vpc_cidr
}

module "subnet" {
  source        = "../../modules/subnet-module"
  vpc_id        = module.vpc.new_vpc
  subnet_config = local.subnet_config
}

module "internet_gateway" {
  source = "../../modules/igw-module"
  vpc_id = module.vpc.new_vpc
}

module "nat_and_app_rtb" {
  source         = "../../modules/nat-gw-module"
  vpc_id         = module.vpc.new_vpc
  web_subnet_ids = module.subnet.web_subnet
  app_subnet_ids = module.subnet.app_subnet
  db_subnet_ids  = module.subnet.db_subnet
  database_rt    = local.database_rt_name
}

module "route_table" {
  source           = "../../modules/routetable-module"
  vpc_id           = module.vpc.new_vpc
  internet_gateway = module.internet_gateway.internet_gateway
  web_subnet_ids   = module.subnet.web_subnet
}

module "network_acl" {
  source                = "../../modules/nacl-module"
  vpc_id                = module.vpc.new_vpc
  web_subnet_ids        = module.subnet.web_subnet
  app_subnet_ids        = module.subnet.app_subnet
  db_subnet_ids         = module.subnet.db_subnet
  web_subnet_cidr_block = local.web_subnet_cidr_block
  app_subnet_cidr_block = local.app_subnet_cidr_block
  db_subnet_cidr_block  = local.db_subnet_cidr_block
  outside_cidr_block    = local.outside_cidr_block
}

module "security_group" {
  source = "../../modules/security-group-module"
  vpc_id = module.vpc.new_vpc
}

module "instance" {
  source             = "../../modules/instance-module"
  vpc_id             = module.vpc.new_vpc
  web_subnet         = module.subnet.web_subnet[0]
  web-security_group = module.security_group.web-security_group

}




