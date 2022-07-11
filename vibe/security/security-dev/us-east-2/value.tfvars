region              = "us-east-2"

created_by          = "Ramana-DevOps"

aws_account         = "117843297914"

app_name            = "vibe"

app_environment     = "dev"

region_tag          = "US-OH"

app_version         = "1.0.0.0"

monitor             = "yes"

cost_center         = "ops"

role                = "security"

reference_id        = "xv173"


kms_info = {
  vibe-encrypt = {
    alias_suffix              = "vibe-encrypt"
    description               = "vibe key to encrypt resources"
    customer_master_key_spec  = "SYMMETRIC_DEFAULT"
    key_usage                 = "ENCRYPT_DECRYPT"
    is_enabled                = "true"
    deletion_window_in_days   = 20
    enable_key_rotation       = true
  }
}