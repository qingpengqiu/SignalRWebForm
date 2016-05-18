<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductsUpdate.aspx.cs" Inherits="_Utility_Products_Update" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>编辑(Products)益跑网</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
<link href="/Common/Calendar.css" type="text/css" rel="stylesheet" />
</head>
<body>
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<!-- 信息输入开始 -->
<br>
<br>
<form id="form1" name="form1" action="ProductsUpdate.aspx" method="post">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top">分类ID：</td>
	<td>
		<% =groups.Controls("idGroup", 200000000, record.idGroup) %>
	</td>
</tr>
<tr>
	<td align="right" valign="top">品牌ID：</td>
	<td>
		<% =groups.Controls("idBrand", 600000000, record.idBrand) %>
	</td>
</tr>
<tr>
	<td align="right" valign="top">产品价格：</td>
	<td>
		<input type="text" id="fPrice" name="fPrice" size="8" maxlength="10" value="<% =record.fPrice.ToString() %>" onblur="if(NullCheck(this)) FloatCheck(this);"  onchange="UpdateHistory(this)"> 
		<span id="check_fPrice" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td>
		<input type="hidden" id="id" name="id" value="<% =record.id.ToString() %>">
		<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
	</td>
	<td>
		<div style="float:left;width:100px;height:32px;">
			<img src="/Images/submit.gif" onclick="Finish()">
		</div>
		<div id="total_echo" style="float:left;width:300px;height:22px;padding-top:10px;" class="check_echo">
		<% =PageResult %>
		</div>
	</td>
</tr>
</table>
</form>

<!-- 信息输入相关javascript代码，需jQuery支持 -->
<script language="javascript">

function Finish()
{
	var check_num = 1;
	//var obj = $("#idGroup")[0];
	//if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
	//var obj = $("#idBrand")[0];
	//if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
	var obj = $("#fPrice")[0];
	if(NullCheck(obj)) if(FloatCheck(obj)) { check_num--; }
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

</script>

</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-17 09:19-->

