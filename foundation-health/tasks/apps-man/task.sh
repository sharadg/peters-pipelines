#!/bin/bash

set -xu

output=$(mysql -uadmin -p$HEALTHWATCH_MYSQL_PASSWORD -h$HEALTHWATCH_MYSQL_IP platform_monitoring -B -e "select value from super_value_metric where name='health.check.CanaryApp.available' order by timestamp desc limit 1;" | tail -1)

if [ $output -ne 1 ]; then
 echo "Health of Apps Man is degregated!!"
 exit 1
fi

exit 0
