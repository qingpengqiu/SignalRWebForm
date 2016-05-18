<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Size.aspx.cs" Inherits="_Member_Size" %>
<html>
<head>
<title>填写身体信息-ERUN360.COM</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/Member.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<center>

<ERUN360:header_user id="header_user" runat="server" />

<div style="width:950px;height:533px;background-image:url(/images/user-back2.gif);">

	<div id="page_nav" style="padding-left:30px;padding-top:20px;">
		<a href="/">首页</a> >
		<a href="/Member/">会员中心</a> > 
		填写身体信息
	</div>

	<form id="form1" name="form1" action="Size.aspx" method="post" autocomplete="off">
	<div id="pageContent" style="float:left;width:528px;">
	<br>

	<!-- 信息输入开始 -->
	<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
	<tr>
		<td align="right" style="width:120px;">身高：</td>
		<td onclick="document.getElementById('demo').src='/images/ydh_c_20.jpg';">
			<input type="text" id="iBodyHeight" name="iBodyHeight" size="3" maxlength="3" value="<% =record.iBodyHeight.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)">
			<span id="check_iBodyHeight" class="check_echo"></span> (厘米)
		</td>
	</tr>
	<tr>
		<td align="right">体重：</td>
		<td onclick="document.getElementById('demo').src='/images/ydh_c_20.jpg';">
			<input type="text" id="iBodyWeight" name="iBodyWeight" size="3" maxlength="3" value="<% =record.iBodyWeight.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)">
			<span id="check_iBodyWeight" class="check_echo"></span> (公斤)
		</td>
	</tr>
	<tr>
		<td align="right">胸-腰-臀围：</td>
		<td onclick="document.getElementById('demo').src='/images/ydh_c_20.jpg';">
			<input type="text" id="iChestSize" name="iChestSize" size="3" maxlength="3" value="<% =record.iChestSize.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)"> 
			<span id="check_iChestSize" class="check_echo"></span>
			<input type="text" id="iWaistSize" name="iWaistSize" size="3" maxlength="3" value="<% =record.iWaistSize.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)"> 
			<span id="check_iWaistSize" class="check_echo"></span>
			<input type="text" id="iHipSize" name="iHipSize" size="3" maxlength="3" value="<% =record.iHipSize.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)"> 
			<span id="check_iHipSize" class="check_echo"></span> (厘米)
		</td>
	</tr>
	<tr>
		<td align="right">脚@长宽：</td>
		<td onclick="document.getElementById('demo').src='/images/ydh_c_21.jpg';">
			<input type="text" id="iFootLength" name="iFootLength" size="3" maxlength="3" value="<% =record.iFootLength.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)"> 
			<span id="check_iFootLength" class="check_echo"></span>
			<input type="text" id="iFootWidth" name="iFootWidth" size="3" maxlength="3" value="<% =record.iFootWidth.ToString() %>" onblur="if(NullCheck(this)) IntegerCheck(this);"  onchange="UpdateHistory(this)"> 
			<span id="check_iFootWidth" class="check_echo"></span> (厘米)
		</td>
	</tr>
	<tr>
		<td>
			<input type="hidden" id="idUser" name="idUser" value="<% =record.idUser.ToString() %>">
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
	<tr>
		<td></td>
		<td>
		</td>
	</tr>
	</table>
	</div>

	<div style="float:right;border-left:solid 1px #CCCCCC;width:340px;height:380px;padding:20px;text-align:left;font-size:12px;line-height:20px;">
		<img id="demo" src="/images/ydh_c_20.jpg" style="border:solid 3px #E0E0E0;" width="330">
	</div>
	</form>

</div>

<script language="javascript">

$.get("/Utility/Ajax/UserSummery.aspx", { }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_right").innerHTML = result;
	}
});

function Finish()
{
	var hv = $("#UpdatedFields")[0].value;
	if(hv.length > 0)
	{
		document.form1.submit();
		return true;
	}
	else
	{
		alert("未修改任何信息");
		//$("#UpdatedFields").html("未修改任何信息");
		return false;
	}
}

</script>

<ERUN360:footer_user id="footer_user" runat="server" />

</center>
</body>
</html>
