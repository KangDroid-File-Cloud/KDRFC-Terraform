output "database_host" {
  description = "Azure SQL Database Host(FQDN)"
  value       = "${helm_release.sqlserver.name}.${kubernetes_namespace_v1.name.metadata.0.name}.svc.cluster.local"
}

output "database_login_password" {
  description = "Azure SQL Database SA Password"
  sensitive   = true
  value       = var.database_login_password
}

output "redis_connection_string" {
  description = "Redis Connection String"
  value       = "${helm_release.redis_cluster.name}.${kubernetes_namespace_v1.name.metadata.0.name}.svc.cluster.local:6379,abortConnect=False"
}
