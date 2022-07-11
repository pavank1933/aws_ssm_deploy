provider "aws" {
  profile = "default"
  region = "us-east-1"
}

module "tf-state-bucket" {
  source                        = "../../../../modules/tf-state-bucket/"
  app_name                      = var.app_name
  app_environment               = var.app_environment
  created_by                    = var.created_by
  tf_bucket                     = var.tf_bucket
  # region                        = var.region
  s3_versioning                 = var.s3_versioning
  s3_enabled                    = var.s3_enabled
  s3_acl                        = var.s3_acl
  s3_force_destroy              = var.s3_force_destroy
  s3_lifecycle_rule_days        = var.s3_lifecycle_rule_days
  s3_storage_class              = var.s3_storage_class
  dynamodb_table                = var.dynamodb_table
  dynamodb_table_read_capacity  = var.dynamodb_table_read_capacity
  dynamodb_table_write_capacity = var.dynamodb_table_write_capacity
  dynamodb_table_hash_key       = var.dynamodb_table_hash_key
  dynamodb_attribute_name       = var.dynamodb_attribute_name
  dynamodb_attribute_type       = var.dynamodb_attribute_type 
  #kms_arn                      = local.kms_arm["vive-encrypt"]
}