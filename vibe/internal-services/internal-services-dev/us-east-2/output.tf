
output "api-ec2-id" {
  value = module.ec2.ec2-id
}

output "auth-ec2-id" {
  value = module.ec2-auth.ec2-id
}

output "model-ec2-id" {
  value = module.ec2-mod.ec2-id
}

output "py-ec2-id" {
  value = module.ec2-py.ec2-id
}
