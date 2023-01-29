resource "helm_release" "mongodb" {
  name      = "mongodb"
  chart     = "${path.module}/chart/mongodb"
  namespace = kubernetes_namespace_v1.name.metadata.0.name
}
