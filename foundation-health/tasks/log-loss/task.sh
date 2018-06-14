#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/logloss | jq ".status")
threshold=0.01

read status <<< $(echo $threshold $output | awk '{if ($1 < $2) print 0; else print 1}')
echo $status


if [$status == 1]
then
    exit 0
fi

echo "We are losing more then 1% of logs! Better scale up dopplers!"
exit 1
