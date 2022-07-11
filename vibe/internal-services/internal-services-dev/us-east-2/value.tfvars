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


api_instance_info = {
  int-api01 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
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
  int-api02 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
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
  int-api01 = {}
  int-api02 = {}
}

api_sg_info = {
  int-api01 = [
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
  int-api02 = [
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
  int-api01 = {
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


auth_instance_info = {
  int-aut01 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
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
  int-aut02 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
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

auth_iam_policy_info = {
  int-aut01 = {}
  int-aut02 = {}
}

auth_sg_info = {
  int-aut01 = [
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
  int-aut02 = [
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

auth_loadbalancer_info = {
  int-aut01 = {
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

mod_instance_info = {
  int-mod01 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
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
  int-mod02 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
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

mod_iam_policy_info = {
  int-mod01 = {}
  int-mod02 = {}
}

mod_sg_info = {
  int-mod01 = [
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
      from_port   = 8090
      to_port     = 8090
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 91
      to_port     = 91
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 92
      to_port     = 92
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
  int-mod02 = [
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
      from_port   = 8090
      to_port     = 8090
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 91
      to_port     = 91
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      type        = "ingress"
      from_port   = 92
      to_port     = 92
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

mod_loadbalancer_info = {
  int-mod01 = {
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

py_instance_info = {
  int-py01 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
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
  int-py02 = {
    instance-info = {
      instance_type    = "m5.large"
      ami_id           = "ami-074cce78125f09d61"
      key_name         = "vibe-app-ec2-key"
      public_ip        = false
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

py_iam_policy_info = {
  int-py01 = {}
  int-py02 = {}
}

py_sg_info = {
  int-py01 = [
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
  int-py02 = [
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
}
