resource "kubernetes_secret_v1" "mongodb_secrets" {
  metadata {
    name      = "kdrfc-database-password"
    namespace = var.deployment_namespace
  }
  type = "Opaque"
  data = {
    "password" = "asdfasdfasdf"
  }
}
