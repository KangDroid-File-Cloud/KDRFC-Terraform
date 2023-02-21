module "mongodb" {
  source               = "./modules/mongodb"
  deployment_namespace = kubernetes_namespace_v1.name.metadata.0.name
}
