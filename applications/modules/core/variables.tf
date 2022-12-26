variable "namespace_application_core" {
  description = "Namespace for application core."
  type        = string
}

variable "database_connection_string" {
  description = "Azure SQL Database Connection Strings"
  type        = string
}

variable "redis_connection_string" {
  description = "Redis Connection String"
  type        = string
}

variable "kdrfc_ingress_host" {
  description = "KDRFC Application Ingress Host"
  type        = string
}
