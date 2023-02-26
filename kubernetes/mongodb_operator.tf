resource "helm_release" "mongodb_operator" {
  repository = "https://mongodb.github.io/helm-charts"
  chart      = "community-operator"
  version    = "0.7.8"
  namespace  = kubernetes_namespace_v1.infrastructure.metadata.0.name
  name       = "mongodb-community-operator"

  set {
    name  = "operator.watchNamespace"
    value = "*"
  }

  set {
    name  = "operator.version"
    value = "v0.7.8"
  }

  set {
    name  = "agent.version"
    value = "12.0.15.7646-1"
  }

  set {
    name  = "versionUpgradeHook.version"
    value = "1.0.6"
  }

  set {
    name  = "readinessProbe.version"
    value = "1.0.12"
  }

  set {
    name  = "registry.agent"
    value = "kangdroid"
  }

  set {
    name  = "registry.versionUpgradeHook"
    value = "kangdroid"
  }

  set {
    name  = "registry.readinessProbe"
    value = "kangdroid"
  }

  set {
    name  = "registry.operator"
    value = "kangdroid"
  }
}
