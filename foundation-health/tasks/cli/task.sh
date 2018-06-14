#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/cfapi | jq ".status")
echo $output

if [ $output == 1 ]
then
    exit 0
fi

echo "Health of CF CLI is degregated!!"
exit 1

