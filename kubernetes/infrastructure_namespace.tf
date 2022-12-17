resource "kubernetes_namespace_v1" "infrastructure" {
  metadata {
    name = "infrastructure"
  }
}
