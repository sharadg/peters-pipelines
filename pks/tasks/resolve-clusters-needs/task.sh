#!/bin/bash

set -u

cp pks-config/creds.yml ~/.pks/creds.yml
git clone pks-clusters pks-clusters-updated
cd pks-clusters-updated

printf "\n\nPKS RUN BOOK: \n"
cat pksRun.sh

./pksRun.sh

pks clusters --json > in-progress.json

printf "\n\nIN-PROGRESS STATE: \n"
cat in-progress.json

rm in-progress.json current.json pksRun.sh

git config user.email "pks-bot@pivotal.io"
git config user.name "pks-bot"
git add .
git commit -m "At Desired State [ci skip]"