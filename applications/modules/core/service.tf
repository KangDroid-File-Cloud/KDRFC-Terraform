resource "kubernetes_service_v1" "kdrfc_core" {
  metadata {
    name      = "kdrfc-core"
    namespace = kubernetes_namespace_v1.application_core.metadata.0.name
  }

  spec {
    type = "ClusterIP"

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    selector = {
      "app" = "kdrfc-core"
    }
  }
}

# resource "kubernetes_ingress_v1" "kdrfc_core" {
#   metadata {
#     name      = "kdrfc-core"
#     namespace = kubernetes_namespace_v1.application_core.metadata.0.name
#     annotations = {
#       "kubernetes.io/ingress.class" = "traefik"
#     }
#   }

#   spec {
#     rule {
#       http {
#         path {
#           path = "/"
#           backend {
#             service {
#               name = kubernetes_service_v1.kdrfc_core.metadata.0.name
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }
