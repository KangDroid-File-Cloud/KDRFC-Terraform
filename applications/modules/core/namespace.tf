resource "kubernetes_namespace_v1" "application_core" {
  metadata {
    name = var.namespace_application_core
  }
}

