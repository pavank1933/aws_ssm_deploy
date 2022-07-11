region            = "us-east-2"

created_by        = "Ramana-DevOps"

aws_account       = "117843297914"

app_name          = "vibe"

app_environment   = "dev"

region_tag        = "US-OH"

app_version       = "1.0.0.0"

monitor           = "yes"

cost_center       = "ops"

role               = "database"

reference_id      = "xv173"

mondb_instance_info = {
  mon-db01 = {
    instance-info = {
      instance_type    = "t3.medium"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
    }
    block-device = [
      {
        device_name             = "/dev/sdb"
        volume_type             = "gp2"
        volume_size             = 100
        delete_on_termination   = true
      }
    ]
  }
  mon-db02 = {
    instance-info = {
      instance_type    = "t3.medium"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
    }
    block-device = [
      {
        device_name             = "/dev/sdb"
        volume_type             = "gp2"
        volume_size             = 100
        delete_on_termination   = true
      }
    ]
  }
}

mondb_iam_policy_info = {
  mon-db01 = {}
  mon-db02 = {}
}

mondb_sg_info = {
  mon-db01 = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
  ]
  mon-db02 = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
  ]
  mysql-db01 = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
  ]
}

#MYSQL CONFIG 

rds_subnet_group_name = "vibe-mysql-db-subnet-group"

db_count = 3

db_user = "vibeadmin"

db_pass = "jUb+4tLyy5a--X8Z"

db_alloc_storage = "30"

db_storage_type = "gp2"

db_engine = "mysql"

db_eng_ver = "5.7"

db_instance_class = "db.t3.small"

db_port = "3306"

db_param_group_name = "default.mysql5.7"

db_skip_final_snapshot = "true"

db_bck_ret_period = "1"

db_apply_immediately = "true"
