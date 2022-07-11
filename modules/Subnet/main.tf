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

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "subnet_info" {
  type = map
}

locals {

  availability-zone-list = flatten([
    for group,azs in var.subnet_info : [
      for zone in azs : {
        "${group}_${zone["az"]}" = {
          "group" = group
          "az" = "${var.region}${zone["az"]}"
          "az-letter" = "${zone["az"]}"
          "newbits" = zone["newbits"]
          "netnum" = zone["netnum"]
          "index" = index(azs, zone)
        }
      }
    ]
  ])

  availability-zone-map = { for item in local.availability-zone-list : 
     keys(item)[0] => values(item)[0]
  }

  pub-sub-map = { for item in local.availability-zone-list : 
     keys(item)[0] => values(item)[0]
     if length(regexall("^public.*", keys(item)[0])) > 0
  }

  pri-sub-map = { for item in local.availability-zone-list : 
     keys(item)[0] => values(item)[0]
     if length(regexall("^private.*", keys(item)[0])) > 0
  }

}

#"${reverse(split("/", each.value.build-source.location))[0]}"

resource "aws_subnet" "subnet" {
  for_each = local.availability-zone-map

  vpc_id                      = var.vpc_id
  cidr_block                  = cidrsubnet(var.vpc_cidr, lookup(each.value, "newbits", null), lookup(each.value, "netnum", null))
  availability_zone           = each.value["az"] == "us-east-2a1" ? "us-east-2a" : null
  map_public_ip_on_launch     = each.value["group"] == "public" ? true : false

  tags = {
    Name                = "${var.app_name}_${each.key}"
    subnet_type         = each.value["group"]
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

resource "aws_route_table" "public" {
  for_each = local.pub-sub-map
  vpc_id   = var.vpc_id
  tags = {
    Name                = "${var.app_name}-${each.value["group"]}_${each.value["az-letter"]}"
    subnet_type         = each.value["group"]
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

resource "aws_route_table" "private" {
  for_each = local.pri-sub-map
  vpc_id   = var.vpc_id
  tags = {
    Name                = "${var.app_name}-${each.value["group"]}_${each.value["az-letter"]}"
    subnet_type         = each.value["group"]
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

resource "aws_route_table_association" "public" {
  for_each       = local.pub-sub-map
  subnet_id      = aws_subnet.subnet["${each.key}"].id
  route_table_id = aws_route_table.public["${each.key}"].id
}

resource "aws_route_table_association" "private" {
  for_each       = local.pri-sub-map
  subnet_id      = aws_subnet.subnet["${each.key}"].id
  route_table_id = aws_route_table.private["${each.key}"].id
}