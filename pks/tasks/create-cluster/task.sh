#!/bin/bash

set -xu

cp pks-config/creds.yml ~/.pks/creds.yml 

pks create-cluster "$PKS_CLUSTER_NAME" \
--external-hostname  "$PKS_CLUSTER_HOSTNAME" \
--plan "$PKS_CLUSTER_PLAN"
 
# wait until cluster is finished creating

set +x

while [ 1 ]
do
    status=`pks cluster "$PKS_CLUSTER_NAME" --json | jq -r '.last_action_state'`

    echo "Status of create-cluster is $status"
    if [ "$status" = "succeeded" ]
    then
        echo "Success"
        exit 0
    fi
    if [ "$status" = "failed" ]
    then
        echo "Failed"
        exit 1
    fi
    sleep 3
done

