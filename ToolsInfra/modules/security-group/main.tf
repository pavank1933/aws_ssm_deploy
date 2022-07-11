variable "cidr_list" {
  type    = list(any)
  default = []
}

variable "sg_info" {
  type = map
}

variable "vpc_id" {
  type  = string
}

variable "app_name" {
  type  = string
}

variable "app_environment" {
  type  = string
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


locals {

  sg-rule-list = flatten([
    for group,rules in var.sg_info : [
      for rule in rules : {
        "${group}-${rule["type"]}-${index(rules, rule)}" = {
          "group" = group
          "rule" = rule
        }
      }
    ]
  ])

  sg-rule-map = { for item in local.sg-rule-list :
     keys(item)[0] => values(item)[0]
  }

}


resource "aws_security_group" "group" {
  for_each = var.sg_info
  name        = "${var.app_name}-${each.key}-sg"
  description = "${var.app_name} ${each.key} SG"
  vpc_id      = var.vpc_id

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

resource "aws_security_group_rule" "rule" {
  for_each = local.sg-rule-map
  type                      = lookup(each.value["rule"], "type", "ingress")
  from_port                 = lookup(each.value["rule"], "from_port", null)
  to_port                   = lookup(each.value["rule"], "to_port", null)
  protocol                  = lookup(each.value["rule"], "protocol", "tcp")
  cidr_blocks               = lookup(each.value["rule"], "cidr_blocks", var.cidr_list)
  security_group_id         = lookup(each.value["rule"], "security_group_id", "${aws_security_group.group["${each.value["group"]}"].id}")
  source_security_group_id  = lookup(each.value["rule"], "source_security_group_id", null)
}
