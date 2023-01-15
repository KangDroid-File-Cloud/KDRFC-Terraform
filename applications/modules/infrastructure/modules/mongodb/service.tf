resource "kubernetes_service_v1" "mongodb_headless_service" {
  metadata {
    name      = "mongodb"
    namespace = var.deployment_namespace
  }

  spec {
    port {
      port        = 27017
      target_port = 27017
    }
    cluster_ip = "None"
    selector = {
      "role" = "mongo"
    }
  }
}
