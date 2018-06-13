#!/bin/bash

set -xu

output=$(mysql -uadmin -p$HEALTHWATCH_MYSQL_PASSWORD -h10.0.5.121 platform_monitoring -B -e "select value from super_value_metric where name='health.check.bosh.director.success' order by timestamp desc limit 1;" | tail -1)

if [ $output -ne 1 ]; then
 echo "Health of BOSH is degregated!!"
 exit 1
fi

exit 0

