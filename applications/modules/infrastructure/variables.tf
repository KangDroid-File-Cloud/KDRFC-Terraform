variable "namespace_application_infrastructure" {
  description = "Kubernetes Namespace for application infrastructure."
  type        = string
}

variable "database_login_password" {
  description = "Database Login Password"
  type        = string
  sensitive   = true
}
