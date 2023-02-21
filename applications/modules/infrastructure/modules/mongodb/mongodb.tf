resource "kubectl_manifest" "mongodb_custom_resource" {
  override_namespace = var.deployment_namespace
  yaml_body          = <<YAML
  apiVersion: mongodbcommunity.mongodb.com/v1
  kind: MongoDBCommunity
  metadata:
    name: kdrfc-database
  spec:
    members: 1
    type: ReplicaSet
    version: "4.4.5"
    security:
      authentication:
        modes: ["SCRAM"]
    users:
      - name: admin
        db: admin
        passwordSecretRef:
          name: ${kubernetes_secret_v1.mongodb_secrets.metadata.0.name}
        roles:
          - name: root
            db: admin
          - name: clusterAdmin
            db: admin
          - name: userAdminAnyDatabase
            db: admin
        scramCredentialsSecretName: mongodb-0
    additionalMongodConfig:
      storage.wiredTiger.engineConfig.journalCompressor: zlib
    statefulSet:
      spec:
        template:
          spec:
            containers:
              - name: mongodb-agent
                readinessProbe:
                  failureThreshold: 50
                  initialDelaySeconds: 10
                  timeoutSeconds: 50
  YAML

  depends_on = [
    kubernetes_secret_v1.mongodb_secrets,
    kubernetes_role_binding_v1.operator_rolebinding,
    kubernetes_role_binding_v1.database_rolebinding
  ]
}
