#!/bin/bash

set -eu

status=$(curl -X GET  healthwatch-api.$SYS_ENDPOINT/info)

if [ "$status" = "HAPI is happy" ]; then
 exit 0
fi

echo "Cannot reach Healthwatch API!!"

exit 1