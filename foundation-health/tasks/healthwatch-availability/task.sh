#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/healthwatch | jq ".status")
echo $status

if [ "$status" = "HAPI is happy" ]; then
 exit 0
fi
echo "Cannot reach Healthwatch API!!"

exit 1