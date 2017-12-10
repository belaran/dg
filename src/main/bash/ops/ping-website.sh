#!/bin/bash

readonly URL=${URL:-'http://wildfly-belaran.7e14.starter-us-west-2.openshiftapps.com/shadow'}

readonly SMTP_SERVER='smtp.corp.redhat.com'
readonly SMTP_PORT='587'
readonly SMTP_URL="${SMTP_SERVER}:${SMTP_PORT}"

readonly FROM='belaran@redhat.com'
readonly RECIPIENT='romain@redhat.com'
readonly TOPIC='Openshift Online Apps Down'

readonly PROJECT_ROOT=${PROJECT_ROOT:-'/home/rpelisse/Repositories/perso/belaran.eu.git'}

echo "Checking website: ${URL}" >> /tmp/website.ping.log
curl "${URL}" 2> /dev/null > /dev/null
sleep 2
curl "${URL}" 2> /dev/null > /dev/null
sleep 2
curl -I "${URL}" 2> /dev/null | grep HTTP | grep -q '200'
for app in dg shadow
do
  if [ ${?} -ne 0 ]; then
    curl "${URL}/${app}" | mailx -r "${RECIPIENT}" -s "${TOPIC}" -S smtp="${SMTP_SERVER}" "${FROM}"
    cd ${PROJECT_ROOT}
    git pull > /dev/null 2> /dev/null
    git push > /dev/null 2> /dev/null
  fi
done
