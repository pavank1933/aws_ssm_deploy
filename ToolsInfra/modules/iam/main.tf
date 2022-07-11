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


variable "iam_policy_info" {
  type = map
}

resource "aws_iam_role_policy" "t" {
  for_each  = var.iam_policy_info
  name      = "${var.app_name}-${each.key}-policy"
  role      = aws_iam_role.role[each.key].id
  policy    = "${file("${each.key}-policy.json")}"
}

resource "aws_iam_role" "role" {
  for_each  = var.iam_policy_info
  name               = "${var.app_name}-${each.key}-role"
  assume_role_policy = "${file("${each.key}-role.json")}"

  tags = {
    Name                = "${var.app_name}-${each.key}-role"
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