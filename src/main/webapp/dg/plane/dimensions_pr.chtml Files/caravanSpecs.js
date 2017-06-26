function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
var thisGroup = "";
var theSpacer = "<td><img src='../caravan/graphics/transparent.gif' width='10' height='1'></td>";
var spacerRow = "<tr><td colspan='3'>&nbsp;</td></tr>";
var fontFront = "<font size='2' face='Times New Roman, Times, serif'>";
var fontHeader = "<font size='2' face='Arial, Helvetica, sans-serif'>";

function formatCaravanSpecs( theGroup, theDescription, theNumbers ){
	if(thisGroup!=theGroup){
		thisGroup = theGroup;
		document.write(spacerRow);
		if(theDescription.length==0){
			document.write('<tr><td valign="top">'+fontHeader+'<b>'+theGroup+'</b></font></td>'+theSpacer+
			'<td align="right" valign="top">'+fontHeader+theNumbers+'</font></td></tr>');
		}
		else{
			document.write('<tr><td colspan="3"><b>'+fontHeader+theGroup+'</font></b></td></tr>'+
			'<tr><td>'+fontFront+theDescription+'</font></td>'+theSpacer+
			'<td align="right" valign="top">'+fontHeader+theNumbers+'</font></td></tr>');
		}
	}//end if
	else{
		document.write('<tr><td>'+fontFront+theDescription+'</font></td>'+theSpacer+
	'<td align="right" valign="top">'+fontHeader+theNumbers+'</font></td></tr>');
	}// end else
}// end function