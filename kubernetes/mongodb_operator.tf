resource "helm_release" "mongodb_operator" {
  repository = "https://mongodb.github.io/helm-charts"
  chart      = "community-operator"
  version    = "0.7.5"
  namespace  = kubernetes_namespace_v1.infrastructure.metadata.0.name
  name       = "mongodb-community-operator"

  set {
    name  = "operator.watchNamespace"
    value = "*"
  }
}
