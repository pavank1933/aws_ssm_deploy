output "subnet-id" {
  value = { for subnet_info, item in aws_subnet.subnet : subnet_info => item.id }
}

output "public-subnet-id-map" {
  value = { for subnet_info, item in aws_subnet.subnet : subnet_info => item.id
    if length(regexall("(?i)public", item["tags"]["subnet_type"])) > 0
  }
}

output "private-subnet-id-map" {
  value = { for subnet_info, item in aws_subnet.subnet : subnet_info => item.id
    if length(regexall("(?i)private", item["tags"]["subnet_type"])) > 0
  }
}

output "private-route-table-id" {
  value = { for subnet_info, item in aws_route_table.private : subnet_info => item.id }
}

output "public-route-table-id" {
  value = { for subnet_info, item in aws_route_table.public : subnet_info => item.id }
}


output "private-subnet-id-list" {
  value = [ for x in aws_subnet.subnet : x.id
    if length(regexall("(?i)private", x["tags"]["subnet_type"])) > 0
  ]
}

output "public-subnet-id-list" {
  value = [ for x in aws_subnet.subnet : x.id
    if length(regexall("(?i)public", x["tags"]["subnet_type"])) > 0
  ]
}