resource "kubernetes_deployment_v1" "kdrfc_core" {
  metadata {
    name      = "kdrfc-core"
    namespace = kubernetes_namespace_v1.application_core.metadata.0.name
  }

  spec {
    selector {
      match_labels = {
        "app" = "kdrfc-core"
      }
    }

    template {
      metadata {
        labels = {
          "app" = "kdrfc-core"
        }
      }

      spec {
        container {
          name              = "kdrfc-core"
          image             = "kangdroid/kdrfc:main"
          image_pull_policy = "Always"
          resources {
            requests = {
              cpu    = "250m"
              memory = "1024Mi"
            }
          }
          readiness_probe {
            initial_delay_seconds = 10
            period_seconds        = 20
            http_get {
              path = "/healthz"
              port = 80
            }
          }
          port {
            container_port = 80
            protocol       = "TCP"
          }

          env {
            name  = "ASPNETCORE_ENVIRONMENT"
            value = "Production"
          }

          env {
            name  = "ConnectionStrings__DatabaseConnection"
            value = var.database_connection_string
          }

          env {
            name  = "ConnectionStrings__CacheConnection"
            value = var.redis_connection_string
          }

          env {
            name  = "ConnectionStrings__MongoDbConnection"
            value = var.mongodb_connection_string
          }

          env {
            name = "OAuth__Google__ClientId"
            value_from {
              secret_key_ref {
                name     = "oauth-secrets"
                key      = "google-client-id"
                optional = true
              }
            }
          }

          env {
            name = "OAuth__Google__ClientSecret"
            value_from {
              secret_key_ref {
                name     = "oauth-secrets"
                key      = "google-client-secret"
                optional = true
              }
            }
          }

          env {
            name = "OAuth__Kakao__ClientId"
            value_from {
              secret_key_ref {
                name     = "oauth-secrets"
                key      = "kakao-client-id"
                optional = true
              }
            }
          }

          env {
            name = "OAuth__Kakao__ClientSecret"
            value_from {
              secret_key_ref {
                name     = "oauth-secrets"
                key      = "kakao-client-secret"
                optional = true
              }
            }
          }
        }
      }
    }
  }
}
