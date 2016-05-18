<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="_Utility_Include_Login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>登录-ERUN360.COM</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta name="generator" content="yipao editor">
<meta name="author" content="">
<meta name="copyright" content="">
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
</head>
<body>
<style type="text/css">
body{background-color:transparent;margin: 8px;padding: 0}
td{font-size: 14px; color: #7c8f7a;font-family: \5FAE\8F6F\96C5\9ED1 }
tr{height:45px;}
#form1{padding-top: 38px;padding-left: 126px;}	
a.zc{float: right;height: 78px;}
#form1 input{height: 26px; background: #f1f6f0;border: 1px solid #e1e8e0;box-shadow: 0 0 4px #ddd inset ; color: #7c8f7a; font-size: 14px; width: 184px;font-family:\5FAE\8F6F\96C5\9ED1;padding-left: 5px}
span{font-size: 12px; color: #e21515;font-family: \5FAE\8F6F\96C5\9ED1}
#form1 #auto,#form1 #goto{width: 20px;height: 13px; border: 0;background: none;margin:0}
font{font-size: 12px;}
img{border: 0}
</style>	
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>

<form id="form1" name="form1" action="Login.aspx" method="post" autocomplete="off">
<a href="/Member/"  target="_blank" class="zc">
	<img class="zc" src="/Images/regis/zc_s.png" alt="">
</a>	
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0"  style="border-collapse:collapse;">
<tr>
	<td align="right" width="56">登录名：</td>
	<td width="270">
		<input type="text" id="cLoginName" name="cLoginName" size="24" maxlength="32"  value="" onblur="if(NullCheck(this)) LengthCheck(this,2,32);"> 
		<span id="check_cLoginName" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td align="right" width="56">密码：</td>
	<td >
		<input type="password" id="cPassword" name="cPassword" size="24" maxlength="32"  value="" onblur="if(NullCheck(this)) if(LengthCheck(this,6,32)) StringCheck(this);"> 
		<span id="check_cPassword" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td></td>
	<td >
		<input type="checkbox" id="auto" name="auto" checked value="1"><font>自动登录</font>
		<input type="checkbox" id="goto" name="goto" checked value="1"><font>去我的首页</font><br>
		<br>
		<div id="submit_command" >
			<img src="/Images/regis/login_h_x.png" onmouseover="ShowSubmit();">
		</div>
		<div id="total_echo"  class="check_echo">
			<% =PageResult %>
		</div>
	</td>
</tr>
</table>
</form>
<script language="javascript">
function ShowSubmit()
{
	var obj = $("#cLoginName")[0];
	if(obj.value.length > 0)
	{
		obj = $("#cPassword")[0];
		if(obj.value.length > 0)
		{
			$("#submit_command").html("<img src='/Images/regis/login_x.png' onclick='Finish()'>");
		}
	}
}
function verifyAll()
{
	var check_num = 2;
	var obj = $("#cLoginName")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) if(LengthCheck(obj,2,32)) { check_num--; }
	obj = $("#cPassword")[0];
	if(NullCheck(obj)) if(LengthCheck(obj,6,32)) if(StringCheck(obj)) { check_num--; }

    return (check_num == 0) ? true : false;
}
function Finish()
{
    if(verifyAll())
    {
       document.form1.submit();
       return true;
    }
	else
	{
		$("#total_echo").html("不行啊！有错误哦！");
	}
    return false;
}
</script>
</body>
</html>
