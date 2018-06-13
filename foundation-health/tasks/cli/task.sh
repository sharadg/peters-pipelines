#!/bin/bash

set -xu

cf login -a https://api.$SYS_ENDPOINT  -u admin -p $ADMIN_PASSWORD -o system -s system --skip-ssl-validation
cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org
cf install-plugin -r CF-Community "Firehose Plugin" -f
output=$(cf nozzle --debug -f ValueMetric | grep -i -m 1 health.check.cliCommand.success)
cleaned=$(echo $output | sed -n -e 's/^.*health.check.cliCommand.success" value//p')
healthStatus=${cleaned:1:2}
echo Status is: $healthStatus

if [ $healthStatus -ne 1 ]; then
 echo "Health of CF CLI is degregated!!"
 exit 1
fi

exit 0
