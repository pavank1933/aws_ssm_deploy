variable "app_name" {
  type = string
}

variable "app_environment" {
  type = string
}

variable "created_by" {
  type = string
}

variable "region_tag" {
  type = string
}

variable "app_version" {
  type = string
}


variable "monitor" {
  type = string
}

variable "cost_center" {
  type = string
}

variable "role" {
  type = string
}

variable "reference_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}


resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name                = "${var.app_name}-vpc"
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