provider "aws" {
  profile = "default"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "accrete-common-infra-terraform"
    key            = "common/tools.tools-dev.us-east-2.tfstate"
    dynamodb_table = "common-infra-terraform"
    encrypt        = true
  }
}

# data "terraform_remote_state" "dev-security" {
#   backend = "s3"
#   config = {
#     region         = var.region
#     key            = "common/security.security-dev.us-east-2.tfstate"
#     bucket         = "common-infra-terraform"
#     dynamodb_table = "common-infra-terraform"
#     encrypt        = true
#   }
# }

data "aws_vpc" "default" {
  default = true
} 

locals {
  #kms_arm          = data.terraform_remote_state.dev-security.outputs.kms-arn
  vpc_id          = data.aws_vpc.default.id 
}

resource "aws_default_subnet" "default_tools_subnet_az" {
  availability_zone = var.default_subnet_az

  tags = {
    Name                = "${var.app_name}_tools_default_subnet"
    app_name            = var.app_name
    app_environment     = var.app_environment
    created_by          = var.created_by
    region_tag          = var.region_tag
    app_version         = var.app_version
    monitor             = var.monitor
    cost_center         = var.cost_center
    role                = var.role
    reference_id        = var.reference_id
  }
}

module "iam" {
  source                      = "../../../../modules/iam/"
  app_name                    = var.app_name
  app_environment             = var.app_environment
  created_by                  = var.created_by
  iam_policy_info             = var.tools_iam_policy_info
  region_tag                  = var.region_tag
  app_version                 = var.app_version
  monitor                     = var.monitor
  cost_center                 = var.cost_center
  role                        = var.role
  reference_id                = var.reference_id
} 

module "sg" {
  source                      = "../../../../modules/security-group/"
  app_name                    = var.app_name
  app_environment             = var.app_environment
  created_by                  = var.created_by
  vpc_id                      = local.vpc_id
  sg_info                     = var.tools_sg_info
  region_tag                  = var.region_tag
  app_version                 = var.app_version
  monitor                     = var.monitor
  cost_center                 = var.cost_center
  role                        = var.role
  reference_id                = var.reference_id
} 

module "ec2" {
  source                    = "../../../../modules/ec2/"
  app_name                  = var.app_name
  app_environment           = var.app_environment
  created_by                = var.created_by
  instance_info             = var.tools_instance_info
  subnet_id                 = aws_default_subnet.default_tools_subnet_az.id
  role_name                 = module.iam.role-name
  security_group_id         = module.sg.sg-id
  region_tag                = var.region_tag
  app_version               = var.app_version
  monitor                   = var.monitor
  cost_center               = var.cost_center
  role                      = var.role
  reference_id              = var.reference_id
}