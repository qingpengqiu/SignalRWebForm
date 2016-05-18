document.write("<style>");
document.write(".nav li.h_gj em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}");
document.write("</style>");


function I2(v)
{
	return (v<10) ? "0" + v : v;
}

function MinutesToHms(atime)
{
	var hours = Math.floor(atime / 60.0);
	var minutes = Math.floor(atime - hours * 60.0);
	var seconds = Math.floor((atime - hours * 60.0 - minutes) * 60.0);

	return { hours : hours, minutes : minutes, seconds : seconds };
}

function RadioAction()
{
	var all = getElementsByName(this.id);
	for(var i=0; i<all.length; i++) all[i].className = "radio2";
	this.className = "radio1";
	document.getElementById(this.id.replace("_radio","")).value = this.getAttribute("value");
}

function CheckboxAction()
{
	if(this.className == "checkbox1") this.className = "checkbox2";
	else this.className = "checkbox1";
	var val = "";
	var all = getElementsByName(this.id);
	for(var i=0; i<all.length; i++) {
		if(all[i].className == "checkbox1") {
			val += all[i].getAttribute("value") + ", ";
		}
		else {
			val += ", ";
		}
	}
	document.getElementById(this.id.replace("_checkbox","")).value = val;
}

function Bind()
{
	var all = document.getElementsByTagName("DIV");  
	for(var i=0;i<all.length;i++)  
	{  
		if(all[i].className == "radio1" || all[i].className == "radio2")
		{
			all[i].onmouseover = function() { this.style.color = "#EE0000"; }
			all[i].onmouseout = function() { this.style.color = ""; }
			all[i].onclick = RadioAction;
		}
		if(all[i].className == "checkbox1" || all[i].className == "checkbox2")
		{
			all[i].onmouseover = function() { this.style.color = "#EE0000"; }
			all[i].onmouseout = function() { this.style.color = ""; }
			all[i].onclick = CheckboxAction;
		}
	}
}
