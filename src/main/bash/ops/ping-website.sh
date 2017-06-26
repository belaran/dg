#!/bin/bash

readonly URL=${URL:-'http://main-belaran.rhcloud.com/'}

readonly SMTP_SERVER='smtp.corp.redhat.com'
readonly SMTP_PORT='587'
readonly SMTP_URL="${SMTP_SERVER}:${SMTP_PORT}"

readonly FROM='belaran@redhat.com'
readonly RECIPIENT='romain@redhat.com'
readonly TOPIC='Openshift Online Apps Down'

readonly PROJECT_ROOT=${PROJECT_ROOT:-'/home/rpelisse/Repositories/perso/belaran.eu.git'}

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
