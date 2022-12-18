resource "helm_release" "sqlserver" {
  name      = "sqlserver"
  chart     = "./chart"
  namespace = kubernetes_namespace_v1.name.metadata.0.name
}
