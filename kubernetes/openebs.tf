resource "helm_release" "openebs_jiva" {
  name       = "openebs-jiva"
  repository = "https://openebs.github.io/jiva-operator"
  chart      = "jiva"
  namespace  = kubernetes_namespace_v1.infrastructure.metadata.0.name

  wait          = true
  wait_for_jobs = true
}

resource "kubectl_manifest" "jiva_storage_policy" {
  yaml_body = <<YAML
  apiVersion: openebs.io/v1alpha1
  kind: JivaVolumePolicy
  metadata:
    name: jiva-volume-policy
    namespace: ${kubernetes_namespace_v1.infrastructure.metadata.0.name}
  spec:
    replicaSC: openebs-hostpath
    target:
      replicationFactor: 3
  YAML

  depends_on = [
    helm_release.openebs_jiva
  ]
}

resource "kubernetes_storage_class_v1" "jiva_storage_class" {
  metadata {
    name = "openebs-jiva-csi"
  }
  storage_provisioner    = "jiva.csi.openebs.io"
  allow_volume_expansion = true
  parameters = {
    cas-type = "jiva"
    policy   = "jiva-volume-policy"
  }

  depends_on = [
    kubectl_manifest.jiva_storage_policy
  ]
}
