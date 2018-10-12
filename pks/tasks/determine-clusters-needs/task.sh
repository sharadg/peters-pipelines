#!/bin/bash

set -u

cp pks-config/creds.yml ~/.pks/creds.yml
cd pks-clusters

pks clusters --json > current.json

echo "\n\nCURRENT STATE: "
cat current.json
echo "\n\nDESIRED STATE: "
cat ${PKS_CLUSTER_JSON_FILE}

set -x
pks-diff -current current.json -desired ${PKS_CLUSTER_JSON_FILE}

set +x
echo "\n\nSTEPS TO GET TO DESIRED STATE: "
cat pksRun.sh