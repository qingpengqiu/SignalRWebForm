<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceActivityUpdate.aspx.cs" Inherits="_Utility_RaceActivity_Update" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>编辑(RaceActivity)益跑网</title>
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
<script language="javascript" src="/Common/jCity.js"></script>

<!-- 信息输入开始 -->
<br>
<br>
<form id="form1" name="form1" action="RaceActivityUpdate.aspx" method="post">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top">活动类别：</td>
	<td>
		<% =GCommon.Controls("活动类别", "select", "idRoadStyle", record.idRoadStyle.ToString()) %>
	</td>
</tr>
<tr>
	<td align="right" valign="top">所在城市：</td>
	<td>
		<select  name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)">
		</select>
		<select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
		</select>
		<script language ="javascript">
		<!--
			BindProvince("北京");
		-->
		</script>
		<input type="text" id="idCity" name="idCity" size="5" readonly value="<% =record.idCity %>">
		<input type="text" id="cCityname" name="cCityname" size="15" readonly value="<% =record.cCityname %>">
	</td>
</tr>
<tr>
	<td align="right" valign="top">活动时间：</td>
	<td>
		<input type="text" id="dOpen" name="dOpen" size="24" maxlength="22" value="<% =record.dOpen.ToString("yyyy-MM-dd HH:mm:ss") %>"  onchange="UpdateHistory(this)"> 
	</td>
</tr>
<tr>
	<td align="right" valign="top">报名开始时间：</td>
	<td>
		<input type="text" id="dJoinBegin" name="dJoinBegin" size="24" maxlength="22" value="<% =record.dJoinBegin.ToString("yyyy-MM-dd HH:mm:ss") %>" onchange="UpdateHistory(this)"> 
	</td>
</tr>
<tr>
	<td align="right" valign="top">报名截止时间：</td>
	<td>
		<input type="text" id="dJoinEnd" name="dJoinEnd" size="24" maxlength="22" value="<% =record.dJoinEnd.ToString("yyyy-MM-dd HH:mm:ss") %>" onchange="UpdateHistory(this)"> 
	</td>
</tr>
<tr>
	<td align="right" valign="top">距离KM：</td>
	<td>
		<input type="text" id="iDistance" name="iDistance" size="8" maxlength="10" value="<% =record.iDistance.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)"> 
		<span id="check_iDistance" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td align="right" valign="top">费用：</td>
	<td>
		<input type="text" id="iFee" name="iFee" size="8" maxlength="10" value="<% =record.iFee.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)"> 
		<span id="check_iFee" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td align="right" valign="top">奖励：</td>
	<td>
		<input type="text" id="iWinner" name="iWinner" size="8" maxlength="10" value="<% =record.iWinner.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)"> 
		<span id="check_iWinner" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td align="right" valign="top">人数限制：</td>
	<td>
		<input type="text" id="iLimit" name="iLimit" size="8" maxlength="10" value="<% =record.iLimit.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)"> 
		<span id="check_iLimit" class="check_echo"></span>
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
	var check_num = 4;
	//var obj = $("#idRoadStyle")[0];
	//if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
	//var obj = $("#idCity")[0];
	//if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
	var obj = $("#iDistance")[0];
	if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
	var obj = $("#iFee")[0];
	if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
	var obj = $("#iWinner")[0];
	if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
	var obj = $("#iLimit")[0];
	if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
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
<!--This file formatted by WizForm 2.1 at 09-17 09:18-->

