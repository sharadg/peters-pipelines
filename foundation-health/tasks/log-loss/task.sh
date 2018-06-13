#!/bin/bash

set -xu

output=$(mysql -uadmin -p$HEALTHWATCH_MYSQL_PASSWORD -h10.0.5.121 platform_monitoring -B -e "select value from super_value_metric where name='Firehose.LossRate.1H' order by timestamp desc limit 1;" | tail -1)
threshold=0.01

read status <<< $(echo $threshold $output | awk '{if ($1 < $2) print 0; else print 1}')

if [ $status -ne 1 ]; then
 echo "We are losing more then 1% of logs! Better scale up dopplers!"
 exit 1
fi

exit 0