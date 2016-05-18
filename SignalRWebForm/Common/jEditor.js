
document.write("<style>");
document.write("option { font-size:12px; }");
document.write(".ubbicon { float:left;width:20px;height:20px;background-image:url(/images/ubb-icon.jpg);cursor:pointer;margin-right:5px; }");
document.write("</style>");
document.write("<div style=\"width:" + ewidth + "px;padding-left:10px;height:28px;padding-top:6px;background-image:url(/images/ubb-back.jpg);font-size:12px;\">");
document.write("<div style=\"float:left;width:190px;height:20px;\">");
document.write("<select name=\"font\" onFocus=\"this.selectedIndex=0\" onChange=\"ubbTag('cContent','[FAMILY=' + this.options[this.selectedIndex].value +']');\" size=\"1\" style=\"width:60px;font-size:12px;\">");
document.write("<option value=\"\" selected>×ÖÌå</option>");
document.write("<option value=\"Î¢ÈíÑÅºÚ\">Î¢ÈíÑÅºÚ</option>");
document.write("<option value=\"ºÚÌå\">ºÚÌå</option>");
document.write("<option value=\"ËÎÌå\">ËÎÌå</option>");
document.write("<option value=\"Arial\">Arial</option>");
document.write("<option value=\"Book Antiqua\">Book Antiqua</option>");
document.write("<option value=\"Century Gothic\">Century Gothic</option>");
document.write("<option value=\"Courier New\">Courier New</option>");
document.write("<option value=\"Georgia\">Georgia</option>");
document.write("<option value=\"Impact\">Impact</option>");
document.write("<option value=\"Tahoma\">Tahoma</option>");
document.write("<option value=\"Times New Roman\">Times New Roman</option>");
document.write("<option value=\"Verdana\">Verdana</option>");
document.write("</select>");
document.write("<select name=\"size\" onFocus=\"this.selectedIndex=0\" onChange=\"ubbTag('cContent','[SIZE=' + this.options[this.selectedIndex].value +']');\" size=\"1\" style=\"width:60px;font-size:12px;\">");
document.write("<option value=\"\" selected>´óÐ¡</option>");
document.write("<option value=\"12\">12</option>");
document.write("<option value=\"14\">14</option>");
document.write("<option value=\"16\">16</option>");
document.write("<option value=\"20\">20</option>");
document.write("</select>");
document.write("<select name=\"color\" onFocus=\"this.selectedIndex=0\" onchange=\"ubbTag('cContent','[COLOR=' + this.options[this.selectedIndex].value +']');\" size=\"1\" style=\"width:60px;font-size:12px;\">");
document.write("<option value=\"\" selected>ÑÕÉ«</option>");
document.write("<option value=\"Black\" style=\"background-color:black;color:black;\">Black</option>");
document.write("<option value=\"White\" style=\"background-color:white;color:white;\">White</option>");
document.write("<option value=\"Red\" style=\"background-color:red;color:red;\">Red</option>");
document.write("<option value=\"Yellow\" style=\"background-color:yellow;color:yellow;\">Yellow</option>");
document.write("<option value=\"Pink\" style=\"background-color:pink;color:pink;\">Pink</option>");
document.write("<option value=\"Green\" style=\"background-color:green;color:green;\">Green</option>");
document.write("<option value=\"Orange\" style=\"background-color:orange;color:orange;\">Orange</option>");
document.write("<option value=\"Purple\" style=\"background-color:purple;color:purple;\">Purple</option>");
document.write("<option value=\"Blue\" style=\"background-color:blue;color:blue;\">Blue</option>");
document.write("<option value=\"Beige\" style=\"background-color:beige;color:beige;\">Beige</option>");
document.write("<option value=\"Brown\" style=\"background-color:brown;color:brown;\">Brown</option>");
document.write("<option value=\"Teal\" style=\"background-color:teal;color:teal;\">Teal</option>");
document.write("<option value=\"Navy\" style=\"background-color:navy;color:navy;\">Navy</option>");
document.write("<option value=\"Maroon\" style=\"background-color:maroon;color:maroon;\">Maroon</option>");
document.write("<option value=\"LimeGreen\" style=\"background-color:limegreen;color:limegreen;\">LimeGreen</option>");
document.write("</select>");
document.write("</div>");
document.write("<div class=\"ubbicon\" style=\"background-position:-4px -6px;\" onclick=\"ubbTag('cContent','[B]');\"></div>");
document.write("<div class=\"ubbicon\" style=\"background-position:-28px -6px;\" onclick=\"ubbTag('cContent','[I]');\"></div>");
document.write("<div class=\"ubbicon\" style=\"background-position:-52px -6px;\" onclick=\"ubbTag('cContent','[U]');\"></div>");
document.write("<div class=\"ubbicon\" style=\"background-position:-77px -6px;\" onclick=\"ubbTag('cContent','[LEFT]');\"></div>");
document.write("<div class=\"ubbicon\" style=\"background-position:-100px -6px;\" onclick=\"ubbTag('cContent','[CENTER]');\"></div>");
document.write("<div class=\"ubbicon\" style=\"background-position:-125px -6px;\" onclick=\"ubbTag('cContent','[RIGHT]');\"></div>");
document.write("<div class=\"ubbicon\" style=\"background-position:-150px -6px;\" onclick=\"ubbTag('cContent','[A]');\" title=\"Ìí¼ÓÁ´½ÓÍøÖ·\"></div>");
document.write("<div class=\"ubbicon\" style=\"background-position:-199px -6px;\" onclick=\"ubbTag('cContent','[FLASH]');\" title=\"Ìí¼ÓFLASHÍøÖ·\"></div>");
document.write("<div class=\"ubbicon\" style=\"background-position:-175px -6px;\" onclick=\"UploadImage(this)\" title=\"Ìí¼ÓÍ¼Æ¬\"></div>");
document.write("</div>");
document.write("");

function ubbTag(target, markup)
{
	var txa=document.getElementsByName(target)[0];
	txa.focus();

	var strEnd = markup.replace(/\[/ig,'[/');
	if (strEnd.indexOf('=')>-1)
	{
		strEnd = strEnd.replace(/(.*?)\=.*?\]/,'$1]');
	}

	var val = "";
	if(markup == "[A]" || markup == "[FLASH]")
	{
		val = prompt("ÇëÊäÈëÍøÖ·»òFLASHÍøÖ·:", "http://");
	}

	if(document.selection && document.selection.type == "Text")
	{
		// IE, Opera
		var oStr = document.selection.createRange();
		
		oStr.text = markup + oStr.text + val + strEnd;
	} 
	else if(window.getSelection && txa.selectionStart>-1) 
	{
		// Netscape
		var st = txa.selectionStart;
		var ed = txa.selectionEnd;
		txa.value = txa.value.substring(0,st) + markup + txa.value.substring(st,ed) + val + strEnd + txa.value.slice(ed);
	} 
	else 
	{
		txa.value += markup + val + strEnd;
	}
}

function insertText(obj,str) 
{
	if(isIE) { obj.value += str; return; }

    if (document.selection) 
	{
        var sel = document.selection.createRange();
        sel.text = str;
    } 
	else if (typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number') 
	{
        var startPos = obj.selectionStart,
            endPos = obj.selectionEnd,
            cursorPos = startPos,
            tmpStr = obj.value;
        obj.value = tmpStr.substring(0, startPos) + str + tmpStr.substring(endPos, tmpStr.length);
        cursorPos += str.length;
        obj.selectionStart = obj.selectionEnd = cursorPos;
    } 
	else {
        obj.value += str;
    }
}
