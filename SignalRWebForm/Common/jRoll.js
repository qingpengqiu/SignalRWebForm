
var ie = ("\v"=="v") ? true : false;

var loop = 0;
var round = 0;
var imgIndex = -1;
var imgCount = homeAds.length;
if(imgCount>5) imgCount = 5;

function SlideInitialize(){}

function Slide()
{
	loop += 60;

	if((round % 5) == 4)
	{
		if(ie) document.getElementById("preImage").filters.alpha.opacity = 100 * Math.cos(loop * 3.14159 / 480.0 / 4.0);
		else document.getElementById("preImage").style.opacity = Math.cos(loop * 3.14159 / 480.0 / 4.0);
	}

	if(loop == 960)
	{
		if((round % 5)==4)
		{
			SlideSwitch();
		}
		loop = 0;
		round++;
	}
}

function SlideSwitch()
{
	imgIndex++;
	if(ie) document.getElementById("preImage").filters.alpha.opacity = 100;
	else document.getElementById("preImage").style.opacity = 1.0;
	document.getElementById("preImage").style.backgroundImage = "url(" + homeAds[imgIndex % imgCount][0] + ")";
	document.getElementById("bigImage").style.backgroundImage = "url(" + homeAds[(imgIndex+1) % imgCount][0] + ")";
	document.getElementById("bigImage").href = homeAds[imgIndex % imgCount][2];
	document.getElementById("longText").innerHTML = homeAds[imgIndex % imgCount][1];

	for(var i=1; i<=imgCount; i++)
	{
		document.getElementById("had_icon" + i).className = "had_no";
	}
	document.getElementById("had_icon" + (imgIndex % imgCount + 1)).className = "had_yes";
}

SlideSwitch();

var slide_interval;

// document.getElementById("bigImage").onclick = function() { 
// 	window.location = this.title; 
// }

slide_interval = setInterval("Slide()", 50);
$("#preImage").prepend('<img id="zhanwei" src="http://img.erun360.com/utility/uploads/2014-09-09/100000093_140854.jpg">')

function RollStop(idx)
{
	imgIndex = idx;
	SlideSwitch();
	clearInterval(slide_interval);
}

function RollBegin()
{
	slide_interval = setInterval("Slide()", 50);
}
