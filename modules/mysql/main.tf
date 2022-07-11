variable "app_name" {
  type = string
}

variable "app_environment" {
  type = string
}

variable "created_by" {
  type = string
}

variable "region_tag" {
  type = string
}

variable "app_version" {
  type = string
}

variable "monitor" {
  type = string
}

variable "cost_center" {
  type = string
}

variable "role" {
  type = string
}

variable "reference_id" {
  type = string
}

variable "priv_subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = map
}

variable "db_count" {
  type = number
}

variable "db_user" {
  type = string
}

variable "db_pass" {
  type = string
}

variable "db_alloc_storage" {
  type = string
}

variable "db_storage_type" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_eng_ver" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_port" {
  type = string
}

variable "db_param_group_name" {
  type = string
}

variable "db_skip_final_snapshot" {
  type = string
}

variable "db_bck_ret_period" {
  type = string
}

variable "db_apply_immediately" {
  type = string
}

variable "rds_subnet_group_name" {
  type = string
}

variable "kms_arn" {
  type = string
}

# -------------- DB Subnet's Group --------
resource "aws_db_subnet_group" "this" {
  name       = var.rds_subnet_group_name
  subnet_ids = var.priv_subnets

  tags = {
    Name                = "${var.app_name}"
    app_name            = var.app_name
    app_environment     = var.app_environment
    created_by          = var.created_by
    region_tag          = var.region_tag
    app_version         = var.app_version
    monitor             = var.monitor
    cost_center         = var.cost_center
    role                = var.role
    reference_id        = var.reference_id
  }
}

# -------------- RDS -----------------------
# Crate MYSQL RDS
# ------------------------------------------
resource "aws_db_instance" "vibe_rds_server" {
  count = var.db_count

  db_subnet_group_name = aws_db_subnet_group.this.id 
  vpc_security_group_ids = [var.security_group_id["mysql-db01"]]

  identifier              = "${format("vibe-db-%03d", count.index + 1)}"
  username                = var.db_user
  password                = var.db_pass

  allocated_storage       = var.db_alloc_storage
  storage_type            = var.db_storage_type
  engine                  = var.db_engine
  engine_version          = var.db_eng_ver
  instance_class          = var.db_instance_class
  port                    = var.db_port
  parameter_group_name    = var.db_param_group_name
  skip_final_snapshot     = var.db_skip_final_snapshot
  backup_retention_period = var.db_bck_ret_period
  apply_immediately       = var.db_apply_immediately
  kms_key_id              = var.kms_arn
  storage_encrypted       = true

  tags = {
    Name                = "${var.app_name}-${format("rds-%03d", count.index + 1)}"
    app_name            = var.app_name
    app_environment     = var.app_environment
    created_by          = var.created_by
    region_tag          = var.region_tag
    app_version         = var.app_version
    monitor             = var.monitor
    cost_center         = var.cost_center
    role                = var.role
    reference_id        = var.reference_id
  }
}

# -------------- RDS -----------------------
# Crate MYSQL read replica
# ------------------------------------------
resource "aws_db_instance" "vibe_rds_server_replica" {
  count = var.db_count

  replicate_source_db  = aws_db_instance.vibe_rds_server[count.index].identifier
  vpc_security_group_ids = [var.security_group_id["mysql-db01"]]
  
  identifier              = "${format("vibe-db-rep-%03d", count.index + 1)}"
  username                = var.db_user
  password                = var.db_pass
  allocated_storage       = var.db_alloc_storage
  storage_type            = var.db_storage_type
  engine                  = var.db_engine
  engine_version          = var.db_eng_ver
  instance_class          = var.db_instance_class
  port                    = var.db_port
  skip_final_snapshot     = var.db_skip_final_snapshot
  backup_retention_period = var.db_bck_ret_period
  apply_immediately       = var.db_apply_immediately
  kms_key_id              = var.kms_arn
  storage_encrypted       = true

  tags = {
    Name                = "${var.app_name}-${format("db-rep-%03d", count.index + 1)}"
    app_name            = var.app_name
    app_environment     = var.app_environment
    created_by          = var.created_by
    region_tag          = var.region_tag
    app_version         = var.app_version
    monitor             = var.monitor
    cost_center         = var.cost_center
    role                = var.role
    reference_id        = var.reference_id
  }
}