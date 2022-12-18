module "application_infrastructure" {
  source = "./modules/infrastructure"

  # Base Infrastructure Namespace
  namespace_application_infrastructure = "kdrfc-infrastructure"
}
