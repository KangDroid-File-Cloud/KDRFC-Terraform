provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

terraform {
  backend "azurerm" {
    key = "applications/sqlserver.tfstate"
  }
}

data "kubernetes_namespace_v1" "infrastructure" {
  metadata {
    name = "infrastructure"
  }
}

resource "helm_release" "sqlserver" {
  name      = "sqlserver"
  chart     = "./chart"
  namespace = data.kubernetes_namespace_v1.infrastructure.metadata.0.name
}

