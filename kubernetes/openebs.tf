resource "helm_release" "openebs" {
  name       = "openebs"
  repository = "https://openebs.github.io/charts"
  chart      = "openebs"
  namespace  = kubernetes_namespace_v1.infrastructure.metadata.0.name
}

