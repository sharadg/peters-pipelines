#!/bin/bash

set -xu

cp pks-config/config ~/.kube/config

kubectl create namespace $K8S_NAMESPACE

kubectl get namespaces