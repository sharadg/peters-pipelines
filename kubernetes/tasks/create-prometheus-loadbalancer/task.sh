#!/bin/bash

set -xu

cp pks-config/config ~/.kube/config

kubectl create -f pks-prometheus/loadBalancer.yml -n $K8S_NAMESPACE

