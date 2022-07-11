provider "aws" {
  profile = "default"
  region = var.region
}

terraform {
  backend "s3" {
    region         = "us-east-2"
    bucket         = "vibe-infra-dev-terraform"
    key            = "vibe/security.security-dev.us-east-2.tfstate"
    dynamodb_table = "vibe-infra-dev-terraform"
    encrypt        = true
  }
}

module "kms" {
  source                      = "../../../../modules/kms/"
  app_name                    = var.app_name
  app_environment             = var.app_environment
  created_by                  = var.created_by
  region_tag                  = var.region_tag
  app_version                 = var.app_version
  monitor                     = var.monitor
  cost_center                 = var.cost_center
  role                        = var.role
  reference_id                = var.reference_id
  kms_info                    = var.kms_info
  aws_account                 = var.aws_account
  manage_user                 = "ramana.mylavarapu"
}