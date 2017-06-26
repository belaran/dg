#!/bin/bash

readonly CSV_FILE=${1}
readonly SERVER_URL=${2:-'http://127.0.0.1:8080/dispatcher/shadow'}
readonly CURL="curl -X PUT ${SERVER_URL}"

if [ ! -e "${CSV_FILE}" ]; then
  echo "Missing CSV File, aborting..."
  exit 1
fi

cat "${CSV_FILE}" |
while
  read line
do
  name=$(echo "${line}" | cut -f1 -d,  | sed -e 's/ //g')
  init=$(echo "${line}" | cut -f2 -d,  | sed -e 's/ //g')
  ${CURL}/${name}/${init}/1
done
