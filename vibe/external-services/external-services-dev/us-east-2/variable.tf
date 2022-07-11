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

variable "ext_py_instance_info" {
  type = map
}

variable "ext_py_sg_info" {
  type = map
}

variable "ext_py_iam_policy_info" {
  type = map
}