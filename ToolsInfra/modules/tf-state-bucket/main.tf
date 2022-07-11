variable "app_name" {
  type = string
}

variable "app_environment" {
  type = string
}

variable "created_by" {
  type = string
}

variable "tf_bucket" {
  type = string
}

# variable "region" {
#   type = string
# }

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

# variable "kms_arn" {
#   type = string
# }

resource "aws_s3_bucket" "accrete_infra_terraform_terraform_state" {
  bucket = var.tf_bucket
  # region = var.region
  versioning {
    enabled = var.s3_versioning
  }
  acl           = var.s3_acl
  force_destroy = var.s3_force_destroy
  lifecycle_rule {
   enabled = var.s3_enabled
   transition {
     days          = var.s3_lifecycle_rule_days
     storage_class = var.s3_storage_class
   }
   noncurrent_version_transition {
     days          = var.s3_lifecycle_rule_days
     storage_class = var.s3_storage_class
   }
 }
  tags = {
    Name                  = "${var.app_name}-${var.app_environment}-s3-tfstate"
    app_name              = var.app_name
    app_environment       = var.app_environment
    created_by            = var.created_by
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_dynamodb_table" "accrete_infra_terraform_state_lock" {
  name           = var.dynamodb_table
  read_capacity  = var.dynamodb_table_read_capacity
  write_capacity = var.dynamodb_table_write_capacity
  hash_key       = var.dynamodb_table_hash_key
  
  tags = {
    Name                  = "${var.app_name}-${var.app_environment}-dynamodb-table"
    app_name              = var.app_name
    app_environment       = var.app_environment
    created_by            = var.created_by
  }
  attribute {
    name = var.dynamodb_attribute_name
    type = var.dynamodb_attribute_type
  }
}