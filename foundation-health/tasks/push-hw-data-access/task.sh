#!/bin/bash

set -eux

cf login -a $CF_API_URL  -u admin -p $CF_PASSWORD --skip-ssl-validation -o system -s system
cf create-space hw-data-access
cf target -o system -s hw-data-access
cd hw-data-access
sysdomain=$(echo $CF_API_URL | sed 's~http[s]*://api.~~g')
echo "cf sys domain: $sysdomain"
echo "" >> manifest.yml
echo "    routes:" >> manifest.yml
echo "    - route: hw-data-access.$sysdomain" >> manifest.yml
echo "Manifest: "
cat manifest.yml
cf push -f manifest.yml --no-start
cf set-env hw-data-access HEALTHWATCH_DB_IP $HEALTHWATCH_MYSQL_IP
cf set-env hw-data-access HEALTHWATCH_DB_PASSWORD $HEALTHWATCH_MYSQL_ADMIN_PASSWORD
cf start hw-data-access

