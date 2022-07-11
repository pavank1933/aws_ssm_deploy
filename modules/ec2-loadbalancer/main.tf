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


variable "subnet_id" {
  type = list
}

variable "security_group_id" {
  type = map
}

variable "vpc_id" {
  type  = string
}

variable "loadbalancer_info" {
  type = map
}


resource "aws_lb" "t" {
  for_each              = var.loadbalancer_info
  name                  = "${var.app_name}-${each.key}"
  internal              = each.value["info"]["internal"]
  load_balancer_type    = each.value["info"]["type"]
  security_groups       = [var.security_group_id[each.key]]
  subnets               = var.subnet_id


  tags = {
    Name                = "${var.app_name}-${each.key}"
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

resource "aws_lb_target_group" "tg" {
  for_each              = var.loadbalancer_info
  name                  = "${var.app_name}-${each.key}"
  port                  = each.value["info"]["port"]
  protocol              = each.value["info"]["protocol"]
  target_type           = each.value["info"]["target_type"]
  deregistration_delay  = each.value["info"]["deregistration_delay"]
  vpc_id                = var.vpc_id

  tags = {
    Name                = "${var.app_name}-${each.key}"
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

resource "aws_lb_listener" "alb_listener" {
  for_each          = var.loadbalancer_info
  load_balancer_arn = aws_lb.t[each.key].arn
  port              = each.value["info"]["lis_port"]
  protocol          = each.value["info"]["lis_protocol"]
  certificate_arn   = each.value["info"]["lis_certificate_arn"]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[each.key].arn
  }
}