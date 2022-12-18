resource "helm_release" "redis_cluster" {
  name       = "rediscluster"
  repository = "https://ot-container-kit.github.io/helm-charts"
  chart      = "redis"
  namespace  = kubernetes_namespace_v1.name.metadata.0.name

  set {
    name  = "redisStandalone.image"
    value = "kangdroid/opstree-redis"
  }

  set {
    name  = "redisExporter.enabled"
    value = "false"
  }

  depends_on = [
    kubernetes_secret_v1.redis_secret
  ]
}

resource "kubernetes_secret_v1" "redis_secret" {
  metadata {
    name      = "redis-secret"
    namespace = kubernetes_namespace_v1.name.metadata.0.name
  }

  type = "Opaque"
  data = {
    "password" = "testPassword@"
  }
}
