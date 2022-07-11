
output "vpc-id" {
  value = module.vpc.vpc-id
}

output "public-subnet-id" {
  value = module.subnet.public-subnet-id-list
}

output "private-subnet-id" {
  value = module.subnet.private-subnet-id-list
}

output "public-subnet-map" {
  value = module.subnet.public-subnet-id-map
}

output "private-subnet-map" {
  value = module.subnet.private-subnet-id-map
}
