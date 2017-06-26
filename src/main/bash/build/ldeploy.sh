#!/bin/bash

#readonly WAR_NAME=$(grep -e name pom.xml  | head -1 | sed -e 's/<name>//g' -e 's;</name>;;g' -e 's; ;;g')
readonly WAR_NAME='ROOT'
readonly WAR_TO_DEPLOY=${1:-"./target/${WAR_NAME}.war"}

if [ -z "${JBOSS_HOME}" ]; then
  echo "No JBOSS_HOME defined, aborting..."
  exit 1
fi

${JBOSS_HOME}/bin/jboss-cli.sh --command="deploy --force ${WAR_TO_DEPLOY}"  --connect
