
String.prototype.replaceAll = function(s1,s2) { return this.replace(new RegExp(s1,"gm"),s2); }
var isIE = !!window.ActiveXObject;
var isIE6 = isIE&&!window.XMLHttpRequest;

var imgOk = "<img src=\"/Images/right.gif\"> ";
var imgErr = "<img src=\"/Images/error.gif\"> ";


function IsNumber(str)
{
	var re = /^[0-9,]*$/;
    return re.test(str);
}

function IsFloat(str)
{
	var re = /^[0-9.,]*$/;
	return re.test(str);
}

function NullCheck(obj)
{
	if(obj.value == "" || obj.value == null)
	{
		$("#check_" + obj.id).html(imgErr);
		return false;
	}
	else
	{
		$("#check_" + obj.id).html(imgOk);
		CheckClear();
		return true;
	}
}

function IntegerCheck(obj)
{
	if(IsNumber(obj.value))
	{
		$("#check_" + obj.id).html(imgOk);
		CheckClear();
		return true;
	}
	else
	{
		$("#check_" + obj.id).html(imgErr + "必须是整数！");
		return false;
	}
}

function FloatCheck(obj)
{
	if(IsFloat(obj.value))
	{
		$("#check_" + obj.id).html(imgOk);
		CheckClear();
		return true;
	}
	else
	{
		$("#check_" + obj.id).html(imgErr + "必须是浮点数！");
		return false;
	}
}

function DateCheck(obj)
{
	if(IsDateTime(obj.value))
	{
		$("#check_" + obj.id).html(imgOk);
		CheckClear();
		return true;
	}
	else
	{
		$("#check_" + obj.id).html(imgErr + "必须是有效日期！");
		return false;
	}
}

function StringCheck(obj)
{
	$("#check_" + obj.id).html(imgOk);
	CheckClear();
	return true;
}

function LengthCheck(obj, n1, n2)
{
	if(obj.value.length >=n1 && obj.value.length <=n2)
	{
		$("#check_" + obj.id).html(imgOk);
		CheckClear();
		return true;
	}
	else
	{
		$("#check_" + obj.id).html(imgErr);
		return false;
	}
}

function RegionCheck(obj, v1, v2)
{
	if( parseInt(obj.value, 10) >=v1 && parseInt(obj.value, 10) <=v2)
	{
		$("#check_" + obj.id).html(imgOk);
		CheckClear();
		return true;
	}
	else
	{
		$("#check_" + obj.id).html(imgErr + "数据超过范围(" + v1 + " .. " + v2 + ")！");
		return false;
	}
}

function SameCheck(obj, last)
{
	if(obj.value == $("#" + last)[0].value)
	{
		$("#check_" + obj.id).html(imgOk);
		CheckClear();
		return true;
	}
	else
	{
		$("#check_" + obj.id).html(imgErr + "两次密码不同");
		return false;
	}
}

function CheckClear()
{
	$("#total_echo").html("");
}

function UpdateHistory(obj)
{
	var hv = $("#UpdatedFields")[0].value;
	if(hv.indexOf(obj.id) < 0) 
	{
		$("#UpdatedFields")[0].value = hv + ";" + obj.id;
	}
}

function UpdateHistory2(obj_id)
{
	var hv = $("#UpdatedFields")[0].value;
	if(hv.indexOf(obj_id) < 0) 
	{
		$("#UpdatedFields")[0].value = hv + ";" + obj_id;
	}
}

function BindCapture()
{
    var all = document.getElementsByTagName("A");  
    for(var i=0;i<all.length;i++)  
    {  
        if(all[i].parentNode.className == "v1" || all[i].parentNode.className == "v2")
        {
			var href = all[i].getAttribute("href");
			all[i].parentNode.onmouseover = function() { this.className = "v1"; }
			all[i].parentNode.onmouseout = function() { this.className = "v2"; }
			all[i].parentNode.onclick = function() { window.location = this.childNodes[0].getAttribute("href"); }
        }
    }
}

function MinuteRand()
{
	var v = new Date();
	var t_y = v.getFullYear();
	var t_m = v.getMonth()+1;
	var t_d = v.getDate();
	var t_h = v.getHours();
	var t_n = v.getMinutes();
	//var t_s = v.getSeconds();
	return t_y + "-" + t_m + "-" + t_d + " " + t_h + ":" + t_n;
}

