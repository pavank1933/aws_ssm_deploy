output "sg-id" {
  value = { for sg_info, item in aws_security_group.group : sg_info => item.id }
}