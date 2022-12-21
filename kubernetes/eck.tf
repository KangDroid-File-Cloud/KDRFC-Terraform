resource "helm_release" "eck_operator" {
  name       = "elastic-kubernetes"
  repository = "https://helm.elastic.co"
  chart      = "eck-operator"
  namespace  = kubernetes_namespace_v1.infrastructure.metadata.0.name
}
