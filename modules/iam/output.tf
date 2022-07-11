output "role-name" {
  value = { for role, item in aws_iam_role.role : role => item.name }
}