output "ec2-id" {
  value = { for ec2_info, item in aws_instance.ec2 : ec2_info => item.id }
}

output "ec2-privateip" {
  value = { for ec2_info, item in aws_instance.ec2 : ec2_info => item.private_dns }
}