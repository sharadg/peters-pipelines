#!/bin/bash

set -xu

cp pks-config/config ~/.kube/config

kubectl create -f pks-prometheus/configMap.yml -n $K8S_NAMESPACE

kubectl get configmaps -n $K8S_NAMESPACE