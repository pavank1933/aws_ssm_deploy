provider "aws" {
  profile = "default"
  region  = var.region
}

terraform {
  backend "s3" {
    region         = "us-east-2"
    bucket         = "vibe-infra-dev-terraform"
    key            = "vibe/vibe-network.vibe-dev.us-east-2.tfstate"
    dynamodb_table = "vibe-infra-dev-terraform"
    encrypt        = true
  }
}

module "vpc" {
  source                    = "../../../../modules/vpc/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  vpc_cidr                  = var.vpc_cidr
}

module "subnet" {
  source                    = "../../../../modules/Subnet/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  vpc_id                    = module.vpc.vpc-id
  vpc_cidr                  = var.vpc_cidr
  region                    = var.region
  subnet_info               = var.subnet_info
}

module "internetgw" {
  source                    = "../../../../modules/internet-gateway/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  vpc_id                    = module.vpc.vpc-id
}

module "internetgateway-route" {
  source                    = "../../../../modules/internet-route/"
  route_table               = module.subnet.public-route-table-id
  inet_gateway_id           = module.internetgw.internet-gatewayid
}

module "natgateway" {
  source                    = "../../../../modules/nat-gateway/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  natgw_subnet_id           = module.subnet.public-subnet-id-map["public_a"]
}


module "natgateway-route" {
  source                    = "../../../../modules/natgw-route/"
  route_table               = module.subnet.private-route-table-id
  natgateway_id             = module.natgateway.natgateway-id
}
