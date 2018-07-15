#!/bin/bash

set -xu

cp pks-config/config ~/.kube/config

kubectl create -f pks-prometheus/deployment.yml