provider "aws" {
  profile = "default"
  region = var.region
}

terraform {
  backend "s3" {
    region         = "us-east-2"
    bucket         = "vibe-infra-dev-terraform"
    key            = "vibe/internal-services.internal-services-dev.us-east-2.tfstate"
    dynamodb_table = "vibe-infra-dev-terraform"
    encrypt        = true
  }
}

data "terraform_remote_state" "dev-network" {
  backend = "s3"
  config = {
    region         = "us-east-2"
    key            = "vibe/vibe-network.vibe-dev.us-east-2.tfstate"
    bucket         = "vibe-infra-dev-terraform"
    dynamodb_table = "vibe-infra-dev-terraform"
    encrypt        = true
  }
}

data "terraform_remote_state" "dev-security" {
  backend = "s3"
  config = {
    region         = "us-east-2"
    key            = "vibe/security.security-dev.us-east-2.tfstate"
    bucket         = "vibe-infra-dev-terraform"
    dynamodb_table = "vibe-infra-dev-terraform"
    encrypt        = true
  }
}

locals {
  kms_arm          = data.terraform_remote_state.dev-security.outputs.kms-arn
  vpc_id          = data.terraform_remote_state.dev-network.outputs.vpc-id
  pri_subnet_id   = data.terraform_remote_state.dev-network.outputs.private-subnet-id
  pri_subnet_map   = data.terraform_remote_state.dev-network.outputs.private-subnet-map
}


module "iam" {
  source                      = "../../../../modules/iam/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  iam_policy_info             = merge(var.api_iam_policy_info, var.auth_iam_policy_info, var.mod_iam_policy_info, var.py_iam_policy_info)
} 

module "sg" {
  source                      = "../../../../modules/security-group/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  vpc_id                      = local.vpc_id
  sg_info                     = merge(var.api_sg_info, var.auth_sg_info, var.mod_sg_info, var.py_sg_info)
} 

module "ec2" {
  source                    = "../../../../modules/ec2/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  instance_info             = var.api_instance_info
  subnet_id                 = local.pri_subnet_map["private_a"]
  role_name                 = module.iam.role-name
  security_group_id         = module.sg.sg-id
  kms_arn                   = local.kms_arm["vibe-encrypt"]
}

module "ec2-auth" {
  source                    = "../../../../modules/ec2/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  instance_info             = var.auth_instance_info
  subnet_id                 = local.pri_subnet_map["private_a"]
  role_name                 = module.iam.role-name
  security_group_id         = module.sg.sg-id
  kms_arn                   = local.kms_arm["vibe-encrypt"]
}

module "ec2-mod" {
  source                    = "../../../../modules/ec2/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  instance_info             = var.mod_instance_info
  subnet_id                 = local.pri_subnet_map["private_a"]
  role_name                 = module.iam.role-name
  security_group_id         = module.sg.sg-id
  kms_arn                   = local.kms_arm["vibe-encrypt"]
}

module "ec2-py" {
  source                    = "../../../../modules/ec2/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  instance_info             = var.py_instance_info
  subnet_id                 = local.pri_subnet_map["private_a"]
  role_name                 = module.iam.role-name
  security_group_id         = module.sg.sg-id
  kms_arn                   = local.kms_arm["vibe-encrypt"]
}

module "loadbalancer" {
  source                    = "../../../../modules/ec2-loadbalancer/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  loadbalancer_info         = merge(var.api_loadbalancer_info, var.auth_loadbalancer_info, var.mod_loadbalancer_info)
  subnet_id                 = [local.pri_subnet_map["private_a"], local.pri_subnet_map["private_c"]]
  security_group_id         = module.sg.sg-id
  vpc_id                    = local.vpc_id
}


module "loadbalancer-attachment" {
  source                    = "../../../../modules/ec2-loadbalancer-attachment/"
  loadbalancer_info         = module.loadbalancer.loadbalancer_tg["int-api01"]
  ec2_id                    = module.ec2.ec2-id
}

module "loadbalancer-attachment-aut" {
  source                    = "../../../../modules/ec2-loadbalancer-attachment/"
  loadbalancer_info         = module.loadbalancer.loadbalancer_tg["int-aut01"]
  ec2_id                    = module.ec2-auth.ec2-id
}

module "loadbalancer-attachment-mod" {
  source                    = "../../../../modules/ec2-loadbalancer-attachment/"
  loadbalancer_info         = module.loadbalancer.loadbalancer_tg["int-mod01"]
  ec2_id                    = module.ec2-mod.ec2-id
}
