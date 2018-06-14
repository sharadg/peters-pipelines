#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/appsman | jq ".status")
echo $output

if [ "$output" -eq "1" ]
then
    exit 0
fi

echo "Health of Apps Man is degregated!!"
exit 1

