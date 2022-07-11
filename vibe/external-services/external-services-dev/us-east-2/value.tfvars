region            = "us-east-2"

created_by        = "Ramana-DevOps"

aws_account       = "117843297914"

app_name          = "vibe"

app_environment   = "dev"

region_tag        = "US-OH"

app_version       = "1.0.0.0"

monitor           = "no"

cost_center       = "engg"

role              = "nginx_web"

reference_id      = "xv173"


ext_py_instance_info = {
  ext-py01 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = true
    }
    block-device = [
      {
        device_name             = "/dev/sdb"
        volume_type             = "gp2"
        volume_size             = 50
        delete_on_termination   = true
      }
    ]
  }
  ext-py02 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-0428fc1ee1bde045a"
      key_name         = "vibe-app-ec2-key"
      public_ip        = true
    }
    block-device = [
      {
        device_name             = "xvdc"
        volume_type             = "gp2"
        volume_size             = 50
        delete_on_termination   = true
      }
    ]
  }
}

ext_py_iam_policy_info = {
  ext-py01 = {}
  ext-py02 = {}
}

ext_py_sg_info = {
  ext-py01 = [
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
      from_port   = 80
      to_port     = 80
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
  ext-py02 = [
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
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
  ]
}
