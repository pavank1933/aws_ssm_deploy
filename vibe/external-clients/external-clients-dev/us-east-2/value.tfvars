region            = "us-east-2"

created_by        = "Ramana-DevOps"

aws_account       = "117843297914"

app_name          = "vibe"

app_environment   = "dev"

region_tag        = "US-OH"

app_version       = "1.0.0.0"

monitor           = "no"

cost_center       = "engg"

role              = "nginx_web_server"

reference_id      = "xv173"


web_instance_info = {
  web-ui01 = {
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
        volume_size             = 1000
        delete_on_termination   = true
        encrypted               = true
      }
    ]
  }
  web-ui02 = {
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
        volume_size             = 1000
        delete_on_termination   = true
        encrypted               = true
      }
    ]
  }
}

web_iam_policy_info = {
  web-ui01 = {}
  web-ui02 = {}
}

web_sg_info = {
  web-ui01 = [
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
      from_port   = 443
      to_port     = 443
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
  web-ui02 = [
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
      from_port   = 443
      to_port     = 443
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
}

web_loadbalancer_info = {
  web-ui01 = {
    info = {
      internal              = false
      type                  = "application"
      port                  = 443
      protocol              = "HTTPS"
      target_type           = "instance"
      deregistration_delay  = 300
      lis_port              = 443
      lis_protocol          = "HTTPS"
      lis_certificate_arn   = "arn:aws:acm:us-east-2:117843297914:certificate/62acbcd5-813f-4d32-b99e-aa8a6ae7d203"
    }
  }
}

api_instance_info = {
  ext-api01 = {
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
  ext-api02 = {
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
}

api_iam_policy_info = {
  ext-api01 = {}
  ext-api02 = {}
}

api_sg_info = {
  ext-api01 = [
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
      from_port   = 443
      to_port     = 443
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
  ext-api02 = [
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
      from_port   = 443
      to_port     = 443
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
}

api_loadbalancer_info = {
  ext-api01 = {
    info = {
      internal              = false
      type                  = "application"
      port                  = 443
      protocol              = "HTTPS"
      target_type           = "instance"
      deregistration_delay  = 300
      lis_port              = 443
      lis_protocol          = "HTTPS"
      lis_certificate_arn   = "arn:aws:acm:us-east-2:117843297914:certificate/62acbcd5-813f-4d32-b99e-aa8a6ae7d203"
    }
  }
}
