resource "helm_release" "sqlserver" {
  name      = "sqlserver"
  chart     = "${path.module}/chart"
  namespace = kubernetes_namespace_v1.name.metadata.0.name

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
