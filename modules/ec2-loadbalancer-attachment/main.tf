variable "loadbalancer_info" {
  type = string
}

variable "ec2_id" {
  type = map
}

resource "aws_lb_target_group_attachment" "at" {
  for_each          = var.ec2_id
  target_id         = var.ec2_id[each.key] 
  target_group_arn  = var.loadbalancer_info
  port              = 80
}