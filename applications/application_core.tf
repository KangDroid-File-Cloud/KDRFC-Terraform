module "application_core" {
  source = "./modules/core"

  # Core Namespace
  namespace_application_core = "kdrfc-core"

  # Database
  database_connection_string = "Data Source=tcp:${module.application_infrastructure.database_host},1433;Initial Catalog=TestDB;User Id=SA;Password=${module.application_infrastructure.database_login_password};Encrypt=False"

  # Redis
  redis_connection_string = module.application_infrastructure.redis_connection_string

  # Ingress Host
  kdrfc_ingress_host = var.kdrfc_host

  depends_on = [
    module.application_infrastructure
  ]
}
