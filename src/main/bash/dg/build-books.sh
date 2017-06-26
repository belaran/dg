#!/bin/bash

readonly TOOL_HOME=${TOOL_HOME:-"$(pwd)/src/main/bash"}
readonly WEBSITE_ROOT=${WEBSITE_HOME:-"$(pwd)/src/main/webapp/dg"}

echo '<html>'
echo '<head>
  <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" href="./style.css"/>
  <link rel="stylesheet" href="./print.css" media="print"/>
  </head>'
echo '<body>'
echo '<div id="main">'
echo '<img src="./img/delta-green-logo.png" style="float: right; margin: 5px;"/>'
for file in $(ls -1 ${WEBSITE_ROOT}/[0-9]*.html | sort -h)
do
    name=$(echo "${file}" | sed -e "s;${WEBSITE_ROOT}/[0-9]*;;" | sed -e 's/-/ /g' | sed -e 's/\.html//')
    name="$(tr '[:lower:]' '[:upper:]' <<< ${name:1:1})${name:2}"
    echo "<h1><a href=\"./$(basename "${file}")\">$name</a></h1>"
    "${TOOL_HOME}/tools.sh" "${WEBSITE_ROOT}/meta.html" "${file}" 'BuildBook' 2> /dev/null
    echo '<br/>'
done
echo '</div>'
echo '</body>'
echo '</html>'
