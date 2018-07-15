#!/bin/bash

set -xu

cp pks-config/config ~/.kube/config

kubectl create -f pks-prometheus/clusterRole.yml -n $K8S_NAMESPACE

kubectl get clusterroles -n $K8S_NAMESPACE

kubectl get clusterrolebindings -n $K8S_NAMESPACE