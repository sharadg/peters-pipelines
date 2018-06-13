#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/cfapi | jq ".status")

if [ $output -ne 1 ]; then
 echo "Health of CF CLI is degregated!!"
 exit 1
fi

exit 0

