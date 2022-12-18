resource "kubernetes_namespace_v1" "name" {
  metadata {
    name = var.namespace_application_infrastructure
  }
}
