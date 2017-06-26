#!/bin/bash

readonly TOOL_HOME=${TOOL_HOME:-"$(pwd)/src/main/bash/dg"}
readonly WEBSITE_ROOT="$(pwd)/src/main/webapp/dg"


echo '<html>'
echo '<head>
  <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" href="./style.css"/>
  <link rel="stylesheet" href="./print.css" media="print"/>
  </head>'
echo '<body>'
echo '<img src="./images/delta-green-logo.png" style="float: right; margin: 5px;"/>'
echo '<h1>Résumés des scénario</h1>'
echo 'Le <a href="./book.html">résumé de la campagne</a>, ou par scénario:'
echo '<ol reversed="reversed">'
curren_dir=$(pwd)
cd ${WEBSITE_ROOT} > /dev/null 2> /dev/null
for file in $(ls -1 [0-9]*.html | sort -n -r )
do
    name=$(echo "$(basename ${file})" | sed -e "s;[0-9]*;;" | sed -e 's/-/ /g' | sed -e 's/\.html//')
    name="$(tr '[:lower:]' '[:upper:]' <<< ${name:1:1})${name:2}"
    echo "  <li><a href=\"./$(basename "${file}")\">$name</a>:"
    "${TOOL_HOME}/tools.sh" 'meta.html' "${file}" ExtractSummary 2> /dev/null
    echo "</li>"
done
cd "${current_dir}"
echo '</ol>'
echo '<br/>'
echo '<h1>Références</h1>'
echo '<ul>'
echo '<li>Index des <a href="meta.html">personnages, acronymes, lieux...</a></li>'
echo "<li><a href=\"./plane/index.html\">Avion</a> de l\'Agent Michael Lafayette.</li>"
echo '</ul>'
echo '<h1>Mind map</h1>'
echo '<a name="mind-map"><img src="./images/plot-overview-transparent-back.png" style="height: 100%; width: 100%" /></a>'
echo '</body>'
echo '</html>'
