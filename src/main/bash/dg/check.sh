#!/bin/bash

readonly APP_NAME=${1:-'MissingRefExtractor'}
readonly WEBSITE_ROOT=${WEBSITE_ROOT:-"$(pwd)/src/main/webapp/dg"}
readonly TOOL_HOME=${TOOL_HOME:-"$(pwd)/src/main/bash"}

for file in ${WEBSITE_ROOT}/[0-9]*.html ; do
  echo "${file}:"
  ${TOOL_HOME}/tools.sh "${WEBSITE_ROOT}/meta.html" "${file}" "${APP_NAME}" \
      2>&1 | sed -e '/execution/d'
done

for file in ${WEBSITE_ROOT}/*.html
do
  xmlwf ${file}
done
