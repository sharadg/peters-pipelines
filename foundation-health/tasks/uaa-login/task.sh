#!/bin/bash

set -xu

output=$(curl -k $HW_DATA_ACCESS_URL/v1/uaa | jq ".status")


if [$output -ne 1]; then
 echo "Cannot reach PCF login (UAA)!!"
 exit 1
fi

exit 0
