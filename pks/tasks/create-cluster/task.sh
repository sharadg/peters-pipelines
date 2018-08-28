#!/bin/bash

set -xu

cp pks-config/creds.yml ~/.pks/creds.yml 

pks create-cluster "$PKS_CLUSTERNAME" \
--external-hostname  "$PKS_CLUSTERHOSTNAME" \
--plan "$PKS_CLUSTERPLAN"
 
# wait until cluster is finished creating

while [ 1 ]
do
    status=`pks cluster "$PKS_CLUSTERNAME" --json | jq -r '.last_action_state'`

    echo Status of create-cluster is $status
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

