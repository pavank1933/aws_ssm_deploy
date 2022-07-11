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


variable "aws_account" {
  type = string
}

variable "manage_user" {
  type = string
}


variable "kms_info" {
  type = map
}


data "aws_iam_policy_document" "p" {
  for_each = var.kms_info
  statement {
    sid = "Allow KMS Use"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
      "*"
    ]
    principals {
          identifiers = [
            "arn:aws:iam::${var.aws_account}:root"
          ]
          type = "AWS"
    }
  }
  statement {
    sid = "admin to kms key"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = [
      "*"
    ]
    principals {
          identifiers = [
            //"arn:aws:iam::${var.aws_account}:user/${var.manage_user}",  // As the user not available commented this line
            "arn:aws:iam::${var.aws_account}:root"
          ]
          type = "AWS"
    }
  }
}

resource "aws_kms_key" "k" {
  for_each                  = var.kms_info
  description               = each.value.description
  key_usage                 = each.value.key_usage
  is_enabled                = each.value.is_enabled
  deletion_window_in_days   = each.value.deletion_window_in_days
  customer_master_key_spec  = each.value.customer_master_key_spec
  enable_key_rotation       = each.value.enable_key_rotation      
  policy                    =  data.aws_iam_policy_document.p[each.key].json

  tags = {
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

resource "aws_kms_alias" "a" {
  for_each      = var.kms_info
  name          = "alias/${var.app_name}-${each.value.alias_suffix}"
  target_key_id = aws_kms_key.k[each.key].key_id
}