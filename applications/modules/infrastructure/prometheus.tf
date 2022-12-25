resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = kubernetes_namespace_v1.name.metadata.0.name
  values = [
    <<YAML
    server:
      persistentVolume:
        storageClass: "openebs-hostpath"
      ingress:
        enabled: true
        annotations:
          kubernetes.io/ingress.class: traefik
        hosts:
          - ${var.prometheus_ingress_host}
      retention: "90d"

    extraScrapeConfigs: |
      - job_name: 'kdrfc-prom'
        scrape_interval: 5s
        static_configs:
          - targets: ["kdrfc-core.kdrfc-core.svc.cluster.local"]
    YAML
  ]
}
