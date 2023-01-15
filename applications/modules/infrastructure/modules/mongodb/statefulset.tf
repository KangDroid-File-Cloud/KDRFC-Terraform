resource "kubernetes_stateful_set_v1" "mongodb_statefulsets" {
  metadata {
    name      = "mongodb"
    namespace = var.deployment_namespace
  }

  # Stateful Specifications
  spec {
    service_name = "mongodb"
    replicas     = 1
    selector {
      match_labels = {
        role = "mongo"
      }
    }

    # Pod Template
    template {
      metadata {
        labels = {
          role        = "mongo"
          environment = "test"
        }
      }

      # Pod Specification
      spec {
        termination_grace_period_seconds = 10
        container {
          name  = "mongo"
          image = "mongo:3.4"
          command = [
            "mongod",
            "--replSet",
            "rs0",
            "--smallfiles",
            "--noprealloc"
          ]
          port {
            container_port = 27017
          }
          volume_mount {
            name       = "mongo-persistent-storage"
            mount_path = "/data/db"
          }
        }

        container {
          name  = "mongo-sidecar"
          image = "kangdroid/mongo-sidecar"
          env {
            name  = "MONGO_SIDECAR_POD_LABELS"
            value = "role=mongo"
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "mongo-persistent-storage"
        annotations = {
          "volume.beta.kubernetes.io/storage-class" = "openebs-hostpath"
        }
      }
      spec {
        access_modes = ["ReadWriteOnce"]
        resources {
          requests = {
            "storage" = "5Gi"
          }
        }
      }
    }
  }
}
