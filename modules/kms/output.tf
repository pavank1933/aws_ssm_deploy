output "kms-id" {
  value = { for key, kms in aws_kms_key.k : key => kms.key_id }
}

output "kms-arn" {
  value = { for key, kms in aws_kms_key.k : key => kms.arn }
}

output "kms-alias-arn" {
  value = { for key, alias in aws_kms_alias.a : key => alias.target_key_arn }
}