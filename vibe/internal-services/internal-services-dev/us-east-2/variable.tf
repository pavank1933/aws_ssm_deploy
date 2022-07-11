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


variable "region" {
  type = string
}

variable "api_instance_info" {
  type = map
}

variable "api_sg_info" {
  type = map
}

variable "api_iam_policy_info" {
  type = map
}

variable "api_loadbalancer_info" {
  type = map
}

variable "auth_instance_info" {
  type = map
}

variable "auth_sg_info" {
  type = map
}

variable "auth_iam_policy_info" {
  type = map
}

variable "auth_loadbalancer_info" {
  type = map
}

variable "mod_instance_info" {
  type = map
}

variable "mod_sg_info" {
  type = map
}

variable "mod_iam_policy_info" {
  type = map
}

variable "mod_loadbalancer_info" {
  type = map
}

variable "py_instance_info" {
  type = map
}

variable "py_sg_info" {
  type = map
}

variable "py_iam_policy_info" {
  type = map
}