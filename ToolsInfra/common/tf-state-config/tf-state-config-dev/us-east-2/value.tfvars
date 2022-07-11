region = "us-east-1"

created_by = "pavan"

aws_account = "673454030352"

app_name = "accrete-tfstate"

app_environment = "dev"

tf_bucket = "accrete-common-infra-terraform"

s3_versioning = "true"

s3_enabled = "true"

s3_acl = "private"

s3_force_destroy = "true"

s3_lifecycle_rule_days = 30

s3_storage_class = "STANDARD_IA"

dynamodb_table = "common-infra-terraform"

dynamodb_table_read_capacity = 1

dynamodb_table_write_capacity = 1

dynamodb_table_hash_key = "LockID"

dynamodb_attribute_name = "LockID"

dynamodb_attribute_type = "S"