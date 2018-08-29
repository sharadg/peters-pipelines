#!/bin/bash

set -xu

cp pks-config/creds.yml ~/.pks/creds.yml 

max=-1
for cluster in $(pks clusters --json | jq -r ".[] | select(.name | startswith(\"$PKS_CLUSTER_PREFIX\")) | .name")
do
  num=${cluster:${#PKS_CLUSTER_PREFIX}}
  [[ $num -gt $max ]] && max=$num
done

if [ "$max" -ne -1 ]
then
  echo "Current Number of Pipeline Created Clusters is: $max"
fi

cluster_num=$((max + 1))
cluster_name="${PKS_CLUSTER_PREFIX}_${cluster_num}"
host_name="${cluster_name}.${PKS_CLUSTER_HOSTNAME}"

echo "Creating New PKS Cluster $cluster_name with hostname $host_name"

set -x

pks create-cluster "$cluster_name" \
--external-hostname  "$host_name" \
--plan "$PKS_CLUSTER_PLAN"
 
# wait until cluster is finished creating

set +x

while [ 1 ]
do
    status=`pks cluster "$cluster_name" --json | jq -r '.last_action_state'`

    echo "Status of create-cluster is $status"
    if [ "$status" = "succeeded" ]
    then
        echo "Created $cluster_name successfully"
        exit 0
    fi
    if [ "$status" = "failed" ]
    then
        echo "Failed..."
        exit 1
    fi
    sleep 30
done
