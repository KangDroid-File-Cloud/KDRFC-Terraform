resource "helm_release" "redis_cluster" {
  name       = "rediscluster"
  repository = "https://ot-container-kit.github.io/helm-charts"
  chart      = "redis-operator"
  namespace  = kubernetes_namespace_v1.infrastructure.metadata.0.name

  set {
    name  = "redisOperator.imageTag"
    value = "redis-operator-0.13.0"
  }

  set {
    name  = "redisOperator.imageName"
    value = "ghcr.io/jaysonsantos/bunderwar"
  }
}
