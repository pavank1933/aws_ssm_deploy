variable "inet_gateway_id" {
  type = string
}

variable "route_table" {
  type = map
}


resource "aws_route" "internet_access" {
  for_each                  = var.route_table
  route_table_id            = each.value
  gateway_id                = var.inet_gateway_id
  destination_cidr_block    = "0.0.0.0/0"
}