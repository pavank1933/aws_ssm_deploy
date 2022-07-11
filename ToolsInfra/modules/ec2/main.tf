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

variable "subnet_id" {
  type = string
}

variable "role_name" {
  type = map
}

variable "security_group_id" {
  type = map
}

variable "instance_info" {
  type = map
}

# variable "kms_arn" {
#   type = string
# }

resource "aws_iam_instance_profile" "t" {
  for_each      = var.instance_info
  name          = "${var.app_name}-${each.key}-ec2-instance"
  role          = var.role_name[each.key]
}


resource "aws_instance" "ec2" {
  for_each                    = var.instance_info
  instance_type               = each.value["instance-info"]["instance_type"]
  ami                         = each.value["instance-info"]["ami_id"]
  key_name                    = each.value["instance-info"]["key_name"]
  associate_public_ip_address = each.value["instance-info"]["public_ip"]
  vpc_security_group_ids      = [var.security_group_id[each.key]]
  subnet_id                   = var.subnet_id
  iam_instance_profile        = aws_iam_instance_profile.t[each.key].name


  dynamic "ebs_block_device" {
    for_each = [for s in var.instance_info["${each.key}"]["block-device"]: {
        device_name           = lookup(s, "device_name", null)
        volume_size           = lookup(s, "volume_size", null)
        delete_on_termination = lookup(s, "delete_on_termination", null)
        volume_type           = lookup(s, "volume_type", null)
        encrypted             = lookup(s, "encrypted", null)
    }]

    content {
      device_name           = ebs_block_device.value.device_name
      volume_type           = ebs_block_device.value.volume_type
      volume_size           = ebs_block_device.value.volume_size
      delete_on_termination = ebs_block_device.value.delete_on_termination
      encrypted             = false
      #kms_key_id            = var.kms_arn
    }
  }

  #Only executes for Jenkins/Ansible Infra.
  #AMI's used here are for Jenkins, Ansible
  #user_data_base64        =  "${ each.value["instance-info"]["ami_id"] == "ami-02e136e904f3da870" ? base64encode(file("../../../../modules/ec2/install_jenkins_userdata.sh")) : (each.value["instance-info"]["ami_id"] == "ami-0b0af3577fe5e3532" ? base64encode(file("../../../../modules/ec2/install_ansible_userdata.sh")) : null)}"

  #user_data_base64        = each.value["instance-info"]["user_data"]
  user_data_base64        = base64encode(file(each.value["instance-info"]["user_data"]))

  tags = {
    Name                = "${var.app_name}-ec2-instance-${each.key}"
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

  volume_tags = {
    Name                = "${var.app_name}-ec2-instance-${each.key}"
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
