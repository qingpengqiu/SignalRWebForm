<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlogGroupList.aspx.cs" Inherits="_Utility_Include_BlogGroupList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>列表(BlogGroup)-ERUN360.COM</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
<link href="/Common/Admin.css" type="text/css" rel="stylesheet" />
</head>
<body>

<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>

<!-- 列表显示 -->


<div id="pageContent" style="display:none;">
<form id="form1" name="form1" action="BlogGroupList.aspx" method="post">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top">标题：</td>
	<td>
		<input type="text" id="cTitle" name="cTitle" size="30" maxlength="32" onblur="if(NullCheck(this)) if(StringCheck(this)) LengthCheck(this,1,32);" value="" >
		<span id="check_cTitle" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td>
	</td>
	<td>
		<div style="float:left;width:100px;height:32px;">
			<img src="/Images/submit.gif" onclick="Finish()">
		</div>
		<div id="total_echo" style="float:left;height:22px;padding-top:10px;" class="check_echo">
		
		</div>
	</td>
</tr>
</table>
</form>
</div>

<div style="cursor:pointer;padding:3px;border:solid 1px #888888;background-color:#A5C316;color:#FFFFFF;width:50px;margin-bottom:3px;display:;" onclick="ItemCreate(this)">+ 创建</div>

<% =PageResult %>

<!-- 弹窗操作（创建，编辑，修改，删除） -->
<script language="javascript">
<!--

function ItemCreate(obj)
{
	obj.style.display = "none";
	$("#pageContent")[0].style.display = "";
}

function ItemDelete(idx, pos, md5)
{
   if (confirm("确定要删除本行记录吗？") == true)
   {
      $.get("BlogGroupDelete.aspx" , { id : idx, checksum : md5 }, function(result) { 
         if(result == "OK")
         {
             $("#trData_" + pos)[0].style.display = "none";
         }
         else
         {
             alert(result);
         }
      });
   }
}

function Finish()
{
	var check_num = 1;
	var obj = $("#cTitle")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) if(LengthCheck(obj,1,32)) { check_num--; }
	if(check_num == 0)
	{
		document.form1.submit();
		return true;
	}
	else
	{
		$("#total_echo").html("不行啊！提交数据还有错误哦！");
	}
	return false;
}

//-->
</script>
</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:40-->

