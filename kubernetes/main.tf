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
    key = "kubernetes/main_infrastructure.tf"
  }
}
