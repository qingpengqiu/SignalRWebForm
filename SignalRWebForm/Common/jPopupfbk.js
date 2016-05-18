
document.write("<div id=\"msgDiv\" style=\"position:absolute;left:0;top:0;z-index:9999;display:none;width:1px;height:1px;\"></div>");
document.write("<div id=\"bgDiv\" style=\"position:absolute;left:0;top:0;z-index:9998;width:1px;height:1px;display:none;\"></div>");

var local_url = "";
var old_scroll;

function PopupShowdl(w, h, title, url) 
{
		if(!!window.ActiveXObject) { if(title=="碌脟脗录") { window.location='/Member/Login.aspx'; } }
	local_url = url;

	var mWidth = w + 20;
	var mHeight = h + 35;

	var str = "";
	str += "<div style=\"width:" + mWidth + "px;height:" + mHeight + "px;background:url(/Images/regis/tdlbj.jpg) no-repeat center;text-align:left;\">";
	str += "<div id=\"titleBar\">";
	str += "<a onclick=\"PopupClose()\" style=\"position: absolute;top: 257px;left: 307px;position: absolute;color: #666;text-decoration: underline;font-size: 14px; cursor: pointer;\">&#20851;&#38381;</a>";
	str += "</div>";
	str += "<iframe src=\"" + url + "\" width=\"" + (mWidth-12) + "\" height=\"" + h + "\" border=\"0\" bordercolor=\"#000000\" frameborder=\"0\" scrolling=\"no\" allowTransparency=\"true\"></iframe>";
	str += "</div>";
	var iWidth = document.body.clientWidth;
	var sHeight = document.body.clientHeight+24;
	if(sHeight < iHeight) sHeight = iHeight;
	if(sHeight < 900) sHeight = 900;

	var bgObj = document.createElement("div");
	bgObj.id = "grDiv";
	bgObj.style.cssText = "position:absolute;left:0px;top:0px;width:" + iWidth + "px;height:" + sHeight + "px;text-align:center;filter:alpha(opacity=60);opacity:0.6;background-color:#000000;z-index:9997;";
	document.body.appendChild(bgObj);

	var msgObj = document.getElementById("msgDiv");
	msgObj.style.width = mWidth + "px";
	msgObj.style.height = mHeight + "px";
	msgObj.innerHTML = str;

	var bgObj=document.getElementById("bgDiv");
	bgObj.style.height = (document.body.offsetHeight) + "px";
	msgObj.style.left = (parseInt(document.body.offsetWidth)/2 - mWidth/2) + "px";
	msgObj.style.top = "180px";
	msgObj.style.display = bgObj.style.display = "";

	var moveX = 0;
	var moveY = 0;
	var moveTop = 0;
	var moveLeft = 0;
	var moveable = false;

	var docMouseMoveEvent = document.onmousemove;
	var docMouseUpEvent = document.onmouseup;

	var titleBar = document.getElementById("titleBar");
	var iWidth = document.documentElement.clientWidth;
	var iHeight = document.body.scrollHeight + 24;

	titleBar.onmousedown = function() 
	{
		var evt = getEvent();
		moveable = true;
		moveX = evt.clientX;
		moveY = evt.clientY;
		moveTop = parseInt(msgObj.style.top);
		moveLeft = parseInt(msgObj.style.left);

		document.onmousemove = function() 
		{
			if (moveable) 
			{
				var evt = getEvent();
				var x = moveLeft + evt.clientX - moveX;
				var y = moveTop + evt.clientY - moveY;
				if ( x > 0  && ( x + w < iWidth)  &&  y > 0  &&  (y + h < iHeight) ) {
					msgObj.style.left = x + "px";
					msgObj.style.top = y + "px";
				}
			}
		};

		document.onmouseup = function () 
		{
			if (moveable) 
			{
				document.onmousemove = docMouseMoveEvent;
				document.onmouseup = docMouseUpEvent;
				moveable = false;
				moveX = 0;
				moveY = 0;
				moveTop = 0;
				moveLeft = 0;
			}
		};
	}

	function getEvent() 
	{
		return window.event || arguments.callee.caller.arguments[0];
	}

	function getPosition() 
	{
		if(document.documentElement && document.documentElement.scrollTop) {
			var top = document.documentElement.scrollTop;
			var left = document.documentElement.scrollLeft;
			var height = document.documentElement.clientHeight;
			var width = document.documentElement.clientWidth;
			console.log(height+"1")
		}
		else if (document.body) 
		{
			var top = document.body.scrollTop;
			var left = document.body.scrollLeft;
			var height = document.documentElement.clientHeight;
			var width = document.documentElement.clientWidth;
			console.log(height+"=2")
		}
		return {top:top,left:left,height:height,width:width };
	}

	function Fix()
	{
		var Position = getPosition();
		var leftadd = (Position.width - w)/2;
		var topadd = (Position.height - h)/2;

		msgObj.style.top = (Position.top + topadd) +"px";

		if(old_scroll!=null) old_scroll();
	}
	
	old_scroll = window.onscroll;
	window.onscroll = Fix;

	Fix();
}

var closeCallback = null;

function PopupClose()
{
	var bgObj=document.getElementById("bgDiv");
	bgObj.style.display = "none";
	var msgObj=document.getElementById("msgDiv");
	msgObj.style.display = "none";
	var grObj=document.getElementById("grDiv");
	document.body.removeChild(grObj);

	if(closeCallback != null) closeCallback();
	window.onscroll = old_scroll;
}

var timerCheck = null;

function StatusIn()
{
	$.get("/Utility/Ajax/Status.aspx", { rnd : Math.random() }, function(result) {
		if(result == "OK") {
			if(timerCheck!=null) clearInterval(timerCheck);
			PopupClose();
			//UserInfoLoad();
			window.location.href= window.location.href;
		}
		else {
			if(result != "FALSE")
			{
				if(timerCheck!=null) clearInterval(timerCheck);
				PopupClose();
				window.location = "/user/" + result + ".aspx";
			}
		}
	});
}

function StatusCheck()
{
	timerCheck = setInterval("StatusIn()", 1000);
}
