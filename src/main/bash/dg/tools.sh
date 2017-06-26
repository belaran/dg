#!/bin/bash

readonly PACKAGE_NAME='org.belaran.dg'
readonly APP_VERSION='1.0'

readonly TOOL_HOME=${TOOL_HOME:-'/home/rpelisse/Private/jdr/cthulhu/dg/dg-app.git/target'}
readonly JAR_HOME=${JAR_HOME:-"${TOOL_HOME}/dg-index-app-${APP_VERSION}-jar-with-dependencies.jar"}

readonly REF_FILE=${1}
readonly HTML_FILE=${2}
readonly APP_NAME=${3:-'RefUpdator'}


if [ -z "${APP_NAME}" ]; then
  echo "Missing Appname"
  exit 1
fi

if [ -z "${REF_FILE}" ]; then
  echo "Missing ref file"
  exit 2
fi

if [ -z "${HTML_FILE}" ]; then
  echo "Missing HTML file"
  exit 3
fi

java -cp "${JAR_HOME}" "${PACKAGE_NAME}.${APP_NAME}" -r "${REF_FILE}" -s "${HTML_FILE}"
