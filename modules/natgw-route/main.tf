variable "natgateway_id" {
  type = string
}

variable "route_table" {
  type = map
}

resource "aws_route" "nat_internetaccess" {
  for_each                  = var.route_table
  route_table_id            = each.value
  nat_gateway_id            = var.natgateway_id
  destination_cidr_block    = "0.0.0.0/0"
}