#!/bin/bash

set -xu

status=$(curl -X POST \
https://uaa.$SYS_ENDPOINT/oauth/token \
-H 'Accept: application/json' \
-H 'Cache-Control: no-cache' \
-H 'Content-Type: application/x-www-form-urlencoded' \
-H 'Postman-Token: 39475842-1a20-440d-8cc0-bb3e0ecca93b' \
-d "username=admin&password=$ADMIN_PASSWORD&grant_type=password" \
-u 'cf:' -k | jq 'select(.access_token != null)')
echo $status

if [ -z "$status" ]; then
 echo "Cannot reach Healthwatch login (UAA)!!"
 exit 1
fi

exit 0
