output "loadbalancer" {
  value = { for loadbalancer, item in aws_lb.t : loadbalancer => item.id }
}

output "loadbalancer_tg" {
  value = { for loadbalancer, item in aws_lb_target_group.tg : loadbalancer => item.arn }
}