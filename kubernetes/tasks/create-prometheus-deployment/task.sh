#!/bin/bash

set -xu

cp pks-config/config ~/.kube/config

kubectl create -f pks-prometheus/deployment.yml -n $K8S_NAMESPACE

kubectl get deployments -n $K8S_NAMESPACE