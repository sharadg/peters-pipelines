#!/bin/bash

set -exu

sysdomain=$(echo $CF_API_URL | sed 's~http[s]*://api.~~g')
status=$(curl -k hw-data-access.$sysdomain/v1/logloss | jq ".status")
threshold=0.01

if [ -z "$status" ]
 then
    echo "Problem hitting hw-data-access app"
    exit 1
fi  

read output <<< $(echo $threshold $status | awk '{if ($1 < $2) print 0; else print 1}')
echo $output


if [ "$output" -eq "1" ]
then
    exit 0
fi

echo "We are losing more then 1% of logs! Better scale up dopplers!"
exit 1
