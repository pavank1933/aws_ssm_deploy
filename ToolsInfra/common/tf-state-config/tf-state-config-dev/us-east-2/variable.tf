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

variable "tf_bucket" {
  type = string
}

variable "s3_versioning" {
  type = string
}

variable "s3_acl" {
  type = string
}

variable "s3_enabled" {
  type = string
}

variable "s3_force_destroy" {
  type = string
}

variable "s3_lifecycle_rule_days" {
  type = number
}

variable "s3_storage_class" {
  type = string
}

variable "dynamodb_table" {
  type = string
}

variable "dynamodb_table_read_capacity" {
  type = number
}

variable "dynamodb_table_write_capacity" {
  type = number
}

variable "dynamodb_table_hash_key" {
  type = string
}

variable "dynamodb_attribute_name" {
  type = string
}

variable "dynamodb_attribute_type" {
  type = string
}