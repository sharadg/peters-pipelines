#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/bosh | jq ".status")

if [ $output -ne 1 ]; then
 echo "Health of BOSH is degregated!!"
 exit 1
fi

exit 0