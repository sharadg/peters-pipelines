#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/bosh | jq ".status")
echo $output

if [ "$output" -eq "1" ]
then
    exit 0
fi

echo "Health of BOSH is degregated!!"
exit 1
