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

variable "mondb_instance_info" {
  type = map
}

variable "mondb_sg_info" {
  type = map
}

variable "mondb_iam_policy_info" {
  type = map
}

variable "rds_subnet_group_name" {
  type = string
}

variable "db_count" {
  type = number
}

variable "db_user" {
  type = string
}

variable "db_pass" {
  type = string
}

variable "db_alloc_storage" {
  type = string
}

variable "db_storage_type" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_eng_ver" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_port" {
  type = string
}

variable "db_param_group_name" {
  type = string
}

variable "db_skip_final_snapshot" {
  type = string
}

variable "db_bck_ret_period" {
  type = string
}

variable "db_apply_immediately" {
  type = string
}