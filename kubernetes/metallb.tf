resource "helm_release" "metallb" {
  name       = "metallb"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metallb"
  namespace  = kubernetes_namespace_v1.infrastructure.metadata.0.name
}
