

resource "kubernetes_service_account_v1" "monogodb_operator" {
  metadata {
    name      = "mongodb-kubernetes-operator"
    namespace = var.deployment_namespace
  }
}

resource "kubernetes_service_account_v1" "mongodb_database" {
  metadata {
    name      = "mongodb-database"
    namespace = var.deployment_namespace
  }
}

resource "kubernetes_role_v1" "mongodb_database_role" {
  metadata {
    name      = kubernetes_service_account_v1.mongodb_database.metadata.0.name
    namespace = var.deployment_namespace
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["patch", "delete", "get"]
  }
}

resource "kubernetes_role_v1" "mongodb_kubernetes_operator" {
  metadata {
    name      = kubernetes_service_account_v1.monogodb_operator.metadata.0.name
    namespace = var.deployment_namespace
  }

  rule {
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "secrets"]
  }

  rule {
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
    api_groups = ["apps"]
    resources  = ["statefulsets"]
  }

  rule {
    verbs      = ["get", "patch", "list", "update", "watch"]
    api_groups = ["mongodbcommunity.mongodb.com"]
    resources  = ["mongodbcommunity", "mongodbcommunity/status", "mongodbcommunity/spec", "mongodbcommunity/finalizers"]
  }
}

resource "kubernetes_role_binding_v1" "operator_rolebinding" {
  metadata {
    name      = "mongodb-kubernetes-operator"
    namespace = var.deployment_namespace
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.monogodb_operator.metadata.0.name
    namespace = var.deployment_namespace
  }
  role_ref {
    kind      = "Role"
    name      = kubernetes_role_v1.mongodb_kubernetes_operator.metadata.0.name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role_binding_v1" "database_rolebinding" {
  metadata {
    name      = "mongodb-database"
    namespace = var.deployment_namespace
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.mongodb_database.metadata.0.name
    namespace = var.deployment_namespace
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role_v1.mongodb_database_role.metadata.0.name
    api_group = "rbac.authorization.k8s.io"
  }
}
