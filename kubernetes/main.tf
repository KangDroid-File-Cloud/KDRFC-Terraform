provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubectl" {
  config_path = "~/.kube/config"
}

terraform {
  backend "azurerm" {
    key = "kubernetes/main_infrastructure.tf"
  }

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">=1.14.0"
    }
  }
}
