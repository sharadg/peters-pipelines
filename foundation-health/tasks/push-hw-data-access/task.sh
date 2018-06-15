#!/bin/bash

set -eux

healthwatch_db_password=$(om -k -t "$OPSMAN_URL" -u "$OPSMAN_USERNAME" -p "$OPSMAN_PASSWORD" credentials -p p-healthwatch -c .mysql.mysql_admin_password -f password)
healthwatch_product_guid=$(om -k -t "$OPSMAN_URL" -u "$OPSMAN_USERNAME" -p "$OPSMAN_PASSWORD" curl -p /api/v0/deployed/products | jq '.[] | select(.installation_name | contains("p-healthwatch")) | .guid')
healthwatch_db_ip=$(om -k -t "$OPSMAN_URL" -u "$OPSMAN_USERNAME" -p "$OPSMAN_PASSWORD" curl -p /api/v0/deployed/products/$healthwatch_product_guid/status | jq -r '."status"[] | select(."job-name" | contains("mysql")) | .ips[0]')
cf_admin_password=$(om -k -t "$OPSMAN_URL" -u "$OPSMAN_USERNAME" -p "$OPSMAN_PASSWORD" credentials -p cf -c .uaa.admin_credentials -f password)
cf login -a $CF_API_URL  -u admin -p $cf_admin_password --skip-ssl-validation -o system -s system

set +e

cf create-space hw-data-access
cf target -o system -s hw-data-access

set -e 

cd hw-data-access
sysdomain=$(echo $CF_API_URL | sed 's~http[s]*://api.~~g')
echo "cf sys domain: $sysdomain"
echo "" >> manifest.yml
echo "    routes:" >> manifest.yml
echo "    - route: hw-data-access.$sysdomain" >> manifest.yml
echo "Manifest: "
cat manifest.yml
cf push -f manifest.yml
cf set-env hw-data-access HEALTHWATCH_DB_IP $healthwatch_db_ip
cf set-env hw-data-access HEALTHWATCH_DB_PASSWORD $healthwatch_db_password
cf restage hw-data-access

