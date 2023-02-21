resource "helm_release" "mongodb_operator" {
  repository = "https://mongodb.github.io/helm-charts"
  chart      = "community-operator"
  version    = "0.7.6"
  namespace  = kubernetes_namespace_v1.infrastructure.metadata.0.name
  name       = "mongodb-community-operator"

  set {
    name  = "operator.watchNamespace"
    value = "*"
  }

  set {
    name  = "registry.operator"
    value = "mohsinonxrm"
  }

  set {
    name  = "registry.versionUpgradeHook"
    value = "mohsinonxrm"
  }

  set {
    name  = "registry.readinessProbe"
    value = "mohsinonxrm"
  }

  set {
    name  = "registry.agent"
    value = "mohsinonxrm"
  }

  set {
    name  = "versionUpgradeHook.version"
    value = "1.0.5"
  }

  set {
    name  = "readinessProbe.name"
    value = "mongodb-kubernetes-readiness"
  }
  set {
    name  = "readinessProbe.version"
    value = "1.0.11"
  }
  set {
    name  = "agent.version"
    value = "12.0.10.7591-1"
  }
}
