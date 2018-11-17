#!/bin/bash

set -xu


pks login -a "$PKS_API_URL" -u "$PKS_API_USERNAME" -p "$PKS_API_PASSWORD" -k

export PKS_USER_PASSWORD="$PKS_API_PASSWORD"

pks get-credentials "$PKS_CLUSTER_NAME"

if [ "$PKS_CONVERT_HOST_TO_IP" = true ]
then
    echo "Converting K8s master hostname to ip address..."
    k8s_master_ip=$(pks cluster "$PKS_CLUSTER_NAME" --json | jq -r ".kubernetes_master_ips | first")
    sed -i "s/server: .*$/server: https:\/\/"$k8s_master_ip":8443/" ~/.kube/config
fi

kubectl cluster-info

cp ~/.kube/config kube-config/config
