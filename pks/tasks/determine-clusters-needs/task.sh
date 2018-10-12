#!/bin/bash

set -u

cp pks-config/creds.yml ~/.pks/creds.yml
git clone pks-clusters pks-clusters-updated
cd pks-clusters-updated

pks clusters --json > current.json

printf "\n\nCURRENT STATE: \n"
cat current.json
printf "\n\nDESIRED STATE: \n"
cat ${PKS_CLUSTER_JSON_FILE}

set -x
set +u

rm -f pksRun.sh

set -u
time=$(date)
echo "echo \"PKS cluster needs determined at: $time \"" > pksRun.sh

pks-diff -current current.json -desired ${PKS_CLUSTER_JSON_FILE}

set +x
printf "\n\nSTEPS TO GET TO DESIRED STATE: \n"
cat pksRun.sh

git config user.email "pks-bot@pivotal.io"
git config user.name "pks-bot"
git add .
git commit -m "Add Run Script For Getting Back To Desired State [ci skip]"