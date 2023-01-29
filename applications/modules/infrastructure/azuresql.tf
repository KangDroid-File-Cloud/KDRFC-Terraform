resource "helm_release" "sqlserver" {
  name      = "sqlserver"
  chart     = "${path.module}/chart/sqlserver"
  namespace = kubernetes_namespace_v1.name.metadata.0.name

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "sa_password"
    value = var.database_login_password
  }

  set {
    name  = "pvc.StorageClass"
    value = "openebs-jiva-csi"
  }
}
