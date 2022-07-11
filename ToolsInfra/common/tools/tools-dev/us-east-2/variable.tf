variable "app_name" {
  type = string
}

variable "app_environment" {
  type = string
}

variable "aws_account" {
  type = string
}

variable "created_by" {
  type = string
}

variable "region" {
  type = string
}

# variable "default_vpc_id" {
#   type = string
# }

# variable "default_subnet_id" {
#   type = string
# }

variable "default_subnet_az" {
  type = string
}

variable "tools_instance_info" {
  type = map
}

variable "tools_sg_info" {
  type = map
}

variable "tools_iam_policy_info" {
  type = map
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