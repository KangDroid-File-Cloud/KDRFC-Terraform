module "application_infrastructure" {
  source = "./modules/infrastructure"

  # Base Infrastructure Namespace
  namespace_application_infrastructure = "kdrfc-infrastructure"

  # Database Password
  database_login_password = "testPassword@"

  # Prometheus Ingress Hosts
  prometheus_ingress_host = var.prom_host
}
