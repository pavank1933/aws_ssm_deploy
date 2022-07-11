provider "aws" {
  profile = "default"
  region = var.region
}

terraform {
  backend "s3" {
    region         = "us-east-2"
    bucket         = "vibe-infra-dev-terraform"
    key            = "vibe/external-services.external-services-dev.us-east-2.tfstate"
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
  pub_subnet_id   = data.terraform_remote_state.dev-network.outputs.public-subnet-id
  pub_subnet_map   = data.terraform_remote_state.dev-network.outputs.public-subnet-map
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
  iam_policy_info             = var.ext_py_iam_policy_info
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
  sg_info                     = var.ext_py_sg_info
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
  instance_info             = var.ext_py_instance_info
  subnet_id                 = local.pub_subnet_map["public_b"]
  role_name                 = module.iam.role-name
  security_group_id         = module.sg.sg-id
  kms_arn                   = local.kms_arm["vibe-encrypt"]
}
