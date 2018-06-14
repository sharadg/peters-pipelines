#!/bin/bash

set -eux

cf login -a $CF_API_URL  -u admin -p $CF_PASSWORD --skip-ssl-validation -o system -s system
cf create-space hw-data-access
cf target -o system -s hw-data-access
cd hw-data-access
cf push -f manifest.yml --no-start
cf set-env hw-data-access HEALTHWATCH_DB_IP $HEALTHWATCH_MYSQL_IP
cf set-env hw-data-access HEALTHWATCH_DB_PASSWORD $HEALTHWATCH_MYSQL_ADMIN_PASSWORD
cf start hw-data-access

