#!/bin/bash

set -xu

cp pks-config/creds.yml ~/.pks/creds.yml 

k8s_master_ip=$(pks cluster "$PKS_CLUSTER_NAME" --json | jq -r ".kubernetes_master_ips | first")

pks get-credentials "$PKS_CLUSTER_NAME"

sed -i "s/server: .*$/server: https:\/\/"$k8s_master_ip":8443/" ~/.kube/config

echo "Use the following as your .kube/config for $PKS_CLUSTER_NAME!! Have fun K8ing :)"

cat ~/.kube/config
