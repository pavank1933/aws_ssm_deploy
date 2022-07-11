region = "us-east-1"

created_by = "Ramana-DevOps"

aws_account = "673454030352"

app_name = "tools-new"

app_environment = "dev"

default_subnet_az = "us-east-1a"

region_tag        = "US-EA"

app_version       = "1.0.0.0"

monitor           = "yes"

cost_center       = "engg"

role                = "security"

reference_id        = "xv173"


tools_instance_info = {
  tools-jenkins = {
    instance-info = {
      instance_type    = "t2.medium"
      ami_id           = "ami-02e136e904f3da870"
      key_name         = "accrete-vibe-pem"
      #user_data        = "base64encode(file('../../../../modules/ec2/install_jenkins_userdata.sh'))"
      user_data        = "../../../../modules/ec2/install_jenkins_userdata.sh"
      public_ip        = true
    }
    block-device = [
      {
        device_name             = "/dev/xvda"
        volume_type             = "gp2"
        volume_size             = 55
        delete_on_termination   = true
      }
    ]
  }
  # tools-ansible = {
  #   instance-info = {
  #     instance_type    = "t2.medium"
  #     ami_id           = "ami-0b0af3577fe5e3532"
  #     key_name         = "accrete-vibe-pem"
  #     #user_data        = "base64encode(file('../../../../modules/ec2/install_ansible_userdata.sh'))"
  #     user_data        = "../../../../modules/ec2/install_ansible_userdata.sh"
  #     public_ip        = true
  #   }
  #   block-device = [
  #     {
  #       device_name             = "/dev/xvda"
  #       volume_type             = "gp2"
  #       volume_size             = 30
  #       delete_on_termination   = true
  #     }
  #   ]
  # }
}

tools_iam_policy_info = {
  tools-jenkins = {}
  # tools-ansible = {}
}

tools_sg_info = {
  tools-jenkins = [
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
      from_port   = 8080
      to_port     = 8080
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
  # tools-ansible = [
  #   {
  #     type        = "egress"
  #     from_port   = 0
  #     to_port     = 65535
  #     protocol    = "-1"
  #     cidr_blocks = [
  #       "0.0.0.0/0"
  #     ]
  #   },
  #   {
  #     type        = "ingress"
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     cidr_blocks = [
  #       "0.0.0.0/0"
  #     ]
  #   }
  # ]
}