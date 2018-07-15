#!/bin/bash

set -xu

pks login -a "$PKS_API_URL" -u "$PKS_API_USERNAME" -p "$PKS_API_PASSWORD" -k

k8s_master_ip=$(pks cluster "$PKS_CLUSTER_NAME" --json | jq -r ".kubernetes_master_ips | first")

pks get-credentials "$PKS_CLUSTER_NAME"

sed -i "s/server: .*$/server: https:\/\/"$k8s_master_ip":8443/" ~/.kube/config


cat << EOF > rbac-config.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
EOF

kubectl create -f rbac-config.yaml