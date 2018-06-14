#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/uaa | jq ".status")
echo $output

if [ "$output" -eq "1" ]
then
    exit 0
fi

echo "Cannot reach PCF login (UAA)!!"
exit 1

