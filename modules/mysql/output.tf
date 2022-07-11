output "rds_instance_endpoints" {
  description = "List vibe RDS instances endpoints"
  value       = [aws_db_instance.vibe_rds_server.*.endpoint, aws_db_instance.vibe_rds_server_replica.*.endpoint]
}