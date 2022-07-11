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

variable "natgw_subnet_id" {
  type = string
}


resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "natgateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.natgw_subnet_id

  tags = {
    Name                = "${var.app_name}-natgw"
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
