#!/bin/bash

set -xu

cp pks-config/creds.yml ~/.pks/creds.yml 
cat pks-clusters/PKS_CLUSTER_JSON_FILE

pks clusters --json > pks-clusters/current.json
pks-diff -current pks-clusters/current.json -desired pks-clusters/PKS_CLUSTER_JSON_FILE

cat pks-clusters/pksRun.sh