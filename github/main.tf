terraform {
  backend "azurerm" {
    key = "github/actions.tfstate"
  }
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

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

# Github Token Variable
variable "github_pat" {
  description = "Github PAT"
  type        = string
  sensitive   = true
}

# Github Repository Variable
variable "github_repository" {
  description = "Github Repository(i.e: account-name/foorepo)"
  type        = string
}

# Base Namespace
resource "kubernetes_namespace_v1" "github_action" {
  metadata {
    name = "github-action"
  }
}

# Certificate Manager Helm
resource "helm_release" "certificate_manager" {
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  name       = "cert-manager"
  namespace  = kubernetes_namespace_v1.github_action.metadata.0.name

  set {
    name  = "installCRDs"
    value = true
  }

  wait          = true
  wait_for_jobs = true
}

# Github Action Runner Controller
resource "helm_release" "github_arc" {
  repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart      = "actions-runner-controller"
  name       = "actinos-runner-controller"
  namespace  = kubernetes_namespace_v1.github_action.metadata.0.name

  set {
    name  = "authSecret.create"
    value = "true"
  }

  set {
    name  = "authSecret.github_token"
    value = var.github_pat
  }

  depends_on = [
    helm_release.certificate_manager
  ]

  wait          = true
  wait_for_jobs = true
}

# Github Action Deployment
resource "kubectl_manifest" "runner_deployment" {
  yaml_body = <<YAML
  apiVersion: actions.summerwind.dev/v1alpha1
  kind: RunnerDeployment
  metadata:
    name: example-runnerdeploy
    namespace: ${kubernetes_namespace_v1.github_action.metadata.0.name}
  spec:
    replicas: 1
    template:
      spec:
        repository: ${var.github_repository}
  YAML

  depends_on = [
    helm_release.github_arc
  ]
}
