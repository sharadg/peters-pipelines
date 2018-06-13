#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/opsman | jq ".status")

if [ $output -ne 1 ]; then
 echo "Health of Ops-Man is degregated!!"
 exit 1
fi

exit 0

