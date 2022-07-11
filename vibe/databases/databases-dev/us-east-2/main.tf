provider "aws" {
  profile = "default"
  region = var.region
}

terraform {
  backend "s3" {
    region         = "us-east-2"
    bucket         = "vibe-infra-dev-terraform"
    key            = "vibe/databases.databases-dev.us-east-2.tfstate"
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
  kms_arm           = data.terraform_remote_state.dev-security.outputs.kms-arn
  vpc_id            = data.terraform_remote_state.dev-network.outputs.vpc-id
  pri_subnet_id     = data.terraform_remote_state.dev-network.outputs.private-subnet-id
  pri_subnet_map    = data.terraform_remote_state.dev-network.outputs.private-subnet-map
}

module "iam" {
  source                      = "../../../../modules/iam/"
  app_name                    = var.app_name
  app_environment             = var.app_environment
  created_by                  = var.created_by
  region_tag                  = var.region_tag
  app_version                 = var.app_version
  monitor                     = var.monitor
  cost_center                 = var.cost_center
  role                        = var.role
  reference_id                = var.reference_id
  iam_policy_info             = var.mondb_iam_policy_info
} 

module "sg" {
  source                      = "../../../../modules/security-group/"
  app_name                    = var.app_name
  app_environment             = var.app_environment
  created_by                  = var.created_by
  region_tag                  = var.region_tag
  app_version                 = var.app_version
  monitor                     = var.monitor
  cost_center                 = var.cost_center
  role                        = var.role
  reference_id                = var.reference_id
  vpc_id                      = local.vpc_id
  sg_info                     = var.mondb_sg_info
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
  instance_info             = var.mondb_instance_info
  subnet_id                 = local.pri_subnet_map["private_c"]
  role_name                 = module.iam.role-name
  security_group_id         = module.sg.sg-id
  kms_arn                   = local.kms_arm["vibe-encrypt"]
}

module "mysql" {
  source                    = "../../../../modules/mysql/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
  priv_subnets              = [local.pri_subnet_map["private_c"],local.pri_subnet_map["private_a"]]
  security_group_id         = module.sg.sg-id
  rds_subnet_group_name     = var.rds_subnet_group_name
  db_count                  = var.db_count
  db_user                   = var.db_user
  db_pass                   = var.db_pass
  db_alloc_storage          = var.db_alloc_storage
  db_storage_type           = var.db_storage_type
  db_engine                 = var.db_engine
  db_eng_ver                = var.db_eng_ver
  db_instance_class         = var.db_instance_class
  db_port                   = var.db_port
  db_param_group_name       = var.db_param_group_name
  db_skip_final_snapshot    = var.db_skip_final_snapshot
  db_bck_ret_period         = var.db_bck_ret_period
  db_apply_immediately      = var.db_apply_immediately
  kms_arn                   = local.kms_arm["vibe-encrypt"]
}
