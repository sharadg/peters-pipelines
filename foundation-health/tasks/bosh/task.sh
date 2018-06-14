#!/bin/bash

set -xu

sysdomain=$(echo $CF_API_URL | sed 's~http[s]*://api.~~g')
output=$(curl -k hw-data-access.$sysdomain/v1/bosh | jq ".status")
echo $output

if [ "$output" -eq "1" ]
then
    exit 0
fi

echo "Health of BOSH is degregated!!"
exit 1
