<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Write.aspx.cs" Inherits="_Utility_BlogsWrite" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>д����</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/Style.css" rel="stylesheet" type="text/css"/>
<link href="/Common/Blog.css" rel="stylesheet" type="text/css"/>
<link href="/Common/Calendar.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<center>

<ERUN360:header_blog id="header_blog" runat="server" />

<script language="javascript" src="/Common/jCity.js"></script>

<div id="blog_b">
	<div id="blog_b_1">
		<div style="float:right;width:950px;height:13px;padding-top:1px;">
			<div id="blog_icon" style="background-color:#DDECCD;" onclick="changeBack(1)"></div>
			<div id="blog_icon" style="background-color:#B5A583;" onclick="changeBack(2)"></div>
			<div id="blog_icon" style="background-color:#6145AB;" onclick="changeBack(3)"></div>
			<div id="blog_icon" style="background-color:#2D62AE;" onclick="changeBack(4)"></div>
		</div>
<script language="javascript">
$.get("/Utility/Ajax/FaceLoad.aspx", { }, function(result) {
	if(result.length > 0) {
		changeBackAction(parseInt(result));
	}
});
</script>
		<div id="blog_title" class="blog_title1">
			<font style="font-size:24px;"><% =u.cLoginName %></font><br>
			<% =PageUser %><br>
			<a href="<% =UrlHelper.MemberUrl(u.id) %>">http://www.erun360.com<% =UrlHelper.MemberUrl(u.id) %></a><br>
			<div id="blog_guide">
				<div class="v2"><a href="/utility/member.aspx">�ҵĲ���</a></div> 
				<div class="v2"><a href="<% =UrlHelper.GalleryUrl(u.id) %>">�ҵ����</a></div> 
			</div>
		</div>
	</div>

	<div id="blog_c">
		<div id="blog_c_left">
			
			<div id="blog_m_top"></div>

			<div style="width:675px;background-image:url(/images/blog/bk-left2.gif);background-position:-0px -17px;font-size:12px;padding-left:20px;padding-right:20px;padding-top:5px;text-align:left;overflow:hidden;">

<form id="form1" name="form1" action="WritePrc.aspx" method="post" autocomplete="off">

<div style="padding-left:4px;">
	�½���
	<% =PageAdmin %>
</div>

<div id="InfoExtention" style="background-color:#FFFFFF;padding:6px;padding-right:18px;"></div>

<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;text-align:left;">
<tr>
	<td>
		<span id="title_1">����</span>��<br>
		<input type="text" id="cTitle" name="cTitle" size="90" maxlength="128" value="" >
	</td>
</tr>
<tr>
	<td>
		<span id="title_2">����</span>��
		<br>
			
		<script language="javascript">var ewidth = 645; </script>
		<script language="javascript" src="/Common/jEditor.js"></script>

		<textarea id="cContent" name="cContent" cols="88" rows="15" style="width:648px;"></textarea>
	</td>
	<td>
	</td>
</tr>
<tr>
	<td>
		�����ڣ�<span id="mygroups"><% =PageList %></span> 
		<span style="color:#0000EE;font-size:12px;cursor:pointer;" onclick="GroupManage()">+ �������</span><br>
	</td>
</tr>
<tr>
	<td>
		<% =PageFrom %>
		<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
		<input type="hidden" id="idCity" name="idCity" size="5" value="0">
		<input type="hidden" id="cCityname" name="cCityname" size="8" value="">
		<input type="hidden" id="idImage" name="idImage" value="">
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
<!-- ��Ϣ������� -->

<div id="srcActivity" style="display:none;">
	<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;border:dotted 1px #CCCCCC;background-color:#F1F6F2;">
	<tr>
		<td align="right" valign="top" style="width:120px;">����</td>
		<td>
			<% =GCommon.Controls("����", "select", "idRoadStyle", "") %>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">���ڳ��У�</td>
		<td>
			<select  name="ddlProvince" id="yuepao" onchange="selectMoreCity(this)">
			</select>
			<select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
			</select>
			<script language ="javascript">
			<!--
				BindProvince("yuepao");
			// -->
			</script>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">�ʱ�䣺</td>
		<td>
			<input type="text" id="dOpen" name="dOpen" size="18" maxlength="22" value="<% =System.DateTime.Now.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);" > 
			<select id="dOpenHours" name="dOpenHours">
			<option value="0">0��</option>
			<option value="1">1��</option>
			<option value="2">2��</option>
			<option value="3">3��</option>
			<option value="4">4��</option>
			<option value="5">5��</option>
			<option value="6">6��</option>
			<option value="7">7��</option>
			<option value="8">8��</option>
			<option selected value="9">9��</option>
			<option value="10">10��</option>
			<option value="11">11��</option>
			<option value="12">12��</option>
			<option value="13">13��</option>
			<option value="14">14��</option>
			<option value="15">15��</option>
			<option value="16">16��</option>
			<option value="17">17��</option>
			<option value="18">18��</option>
			<option value="19">19��</option>
			<option value="20">20��</option>
			<option value="21">21��</option>
			<option value="22">22��</option>
			<option value="23">23��</option>
			</select>
			<select id="dOpenMinutes" name="dOpenMinutes">
			<option selected value="0">0��</option>
			<option value="10">10��</option>
			<option value="15">15��</option>
			<option value="20">20��</option>
			<option value="25">25��</option>
			<option value="30">30��</option>
			<option value="35">35��</option>
			<option value="40">40��</option>
			<option value="45">45��</option>
			<option value="50">50��</option>
			<option value="55">55��</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">����ʱ�䣺</td>
		<td>
			<input type="text" id="dJoinBegin" name="dJoinBegin" size="18" maxlength="22" value="<% =System.DateTime.Now.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);" > 
			<select id="dJoinBeginHours" name="dJoinBeginHours">
			<option selected value="0">0��</option>
			<option value="1">1��</option>
			<option value="2">2��</option>
			<option value="3">3��</option>
			<option value="4">4��</option>
			<option value="5">5��</option>
			<option value="6">6��</option>
			<option value="7">7��</option>
			<option value="8">8��</option>
			<option  value="9">9��</option>
			<option value="10">10��</option>
			<option value="11">11��</option>
			<option value="12">12��</option>
			<option value="13">13��</option>
			<option value="14">14��</option>
			<option value="15">15��</option>
			<option value="16">16��</option>
			<option value="17">17��</option>
			<option value="18">18��</option>
			<option value="19">19��</option>
			<option value="20">20��</option>
			<option value="21">21��</option>
			<option value="22">22��</option>
			<option value="23">23��</option>
			</select>
			-
			<input type="text" id="dJoinEnd" name="dJoinEnd" size="18" maxlength="22" value="<% =System.DateTime.Now.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);" > 
			<select id="dJoinEndHours" name="dJoinEndHours">
			<option value="0">0��</option>
			<option value="1">1��</option>
			<option value="2">2��</option>
			<option value="3">3��</option>
			<option value="4">4��</option>
			<option value="5">5��</option>
			<option value="6">6��</option>
			<option value="7">7��</option>
			<option value="8">8��</option>
			<option value="9">9��</option>
			<option value="10">10��</option>
			<option value="11">11��</option>
			<option value="12">12��</option>
			<option value="13">13��</option>
			<option value="14">14��</option>
			<option value="15">15��</option>
			<option value="16">16��</option>
			<option value="17">17��</option>
			<option value="18">18��</option>
			<option value="19">19��</option>
			<option value="20">20��</option>
			<option value="21">21��</option>
			<option value="22">22��</option>
			<option selected value="23">23��</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">���룺</td>
		<td>
			<input type="text" id="iDistance" name="iDistance" size="8" maxlength="10" value="0" onblur="if(NullCheck(this)) IntegerCheck(this);" > ���� 
			<span id="check_iDistance" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">���ã�</td>
		<td>
			<input type="text" id="iFee" name="iFee" size="8" maxlength="10" value="0" onblur="if(NullCheck(this)) IntegerCheck(this);" > Ԫ 
			<span id="check_iFee" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">������</td>
		<td>
			<input type="text" id="iWinner" name="iWinner" size="8" maxlength="10" value="0" onblur="if(NullCheck(this)) IntegerCheck(this);" > 
			<span id="check_iWinner" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">�������ƣ�</td>
		<td>
			<input type="text" id="iLimit" name="iLimit" size="8" maxlength="10" value="0" onblur="if(NullCheck(this)) IntegerCheck(this);" > 
			<span id="check_iLimit" class="check_echo"></span>
		</td>
	</tr>
	</table>
</div>

<div id="srcClub" style="display:none;">
	<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;border:dotted 1px #CCCCCC;background-color:#F1F6F2;">
	<tr>
		<td align="right" valign="top" style="width:120px;">���ڳ��У�</td>
		<td>
			<select  name="ddlProvince" id="julebu" onchange="selectMoreCity(this)">
			</select>
			<select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
			</select>
			<script language ="javascript">
			<!--
				BindProvince("julebu");
			// -->
			</script>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">��Ա�������ƣ�</td>
		<td>
			<input type="text" id="iMemberLimit" name="iMemberLimit" size="8" maxlength="10" value="0" onblur="if(NullCheck(this)) IntegerCheck(this);" > 
			<span id="check_iMemberLimit" class="check_echo"></span>
		</td>
	</tr>
	</table>
</div>

<div id="srcCompetetion" style="display:none;">
	<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;border:dotted 1px #CCCCCC;background-color:#F1F6F2;">
	<tr>
		<td align="right" valign="top" style="width:120px;">�������ͣ�</td>
		<td>
			<% =GCommon.Controls("��������", "select", "idCompeteStyle", "") %>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">���ڳ��У�</td>
		<td>
			<select  name="ddlProvince" id="jingsai" onchange="selectMoreCity(this)">
			</select>
			<select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
			</select>
			<script language ="javascript">
			<!--
				BindProvince("jingsai");
			-->
			</script>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">����ʱ�䣺</td>
		<td>
			<input type="text" id="dRaceBegin" name="dRaceBegin" size="18" maxlength="22" value="<% =System.DateTime.Now.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);" > - 
			<input type="text" id="dRaceEnd" name="dRaceEnd" size="18" maxlength="22" value="<% =System.DateTime.Now.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);" > 
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">����ʱ�䣺</td>
		<td>
			<input type="text" id="dJoinBegin" name="dJoinBegin" size="18" maxlength="22" value="<% =System.DateTime.Now.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);" > - 
			<input type="text" id="dJoinEnd" name="dJoinEnd" size="18" maxlength="22" value="<% =System.DateTime.Now.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);" > 
		</td>
	</tr>
	</table>
</div>

<div id="srcProducts" style="display:none;">
	<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;border:dotted 1px #CCCCCC;background-color:#F1F6F2;">
	<tr>
		<td align="right" valign="top" style="width:120px;">����ID��</td>
		<td>
			<% =groups.Controls("idGroup", 200000000, 0) %>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">Ʒ��ID��</td>
		<td>
			<% =groups.Controls("idBrand", 600000000, 0) %>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">��Ʒ�۸�</td>
		<td>
			<input type="text" id="fPrice" name="fPrice" size="8" maxlength="10" value="0" onblur="if(NullCheck(this)) FloatCheck(this);" > Ԫ
			<span id="check_fPrice" class="check_echo"></span>
		</td>
	</tr>
	</table>
</div>


<script language="javascript">

function SwitchTo(obj)
{
	if(obj.value == "Blog") { 
		$("#InfoExtention").html(""); 
		$("#title_1").html("����"); 
		$("#title_2").html("����"); 
		return; 
	}
	$("#InfoExtention").html($("#src"+ obj.value)[0].innerHTML);
	$("#title_1").html("����"); 
	$("#title_2").html("���"); 
}

function SwitchTo2(v)
{
	if(v == "Blog") { 
		$("#InfoExtention").html(""); 
		$("#title_1").html("����"); 
		$("#title_2").html("����"); 
		return; 
	}
	$("#InfoExtention").html($("#src"+ v)[0].innerHTML);
	$("#title_1").html("����"); 
	$("#title_2").html("���"); 
}

<% =PageSwitch %>

function Finish()
{
	var check_num = 2;
	var obj = $("#cTitle")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) if(LengthCheck(obj,2,128)) { check_num--; }
	var obj = $("#cContent")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) { check_num--; }
	if(check_num == 0)
	{
		document.form1.submit();
		return true;
	}
	else
	{
		$("#total_echo").html("���а����ύ���ݻ��д���Ŷ��");
	}
	return false;
}


</script>

				
				<div style="clear:both;width:715px;height:20px;"></div>
			</div>

			<div id="blog_m_bot"></div>
			<div id="blog_m_spc"></div>

		</div>
		
		<!--�Ҳ��û���Ϣ-->
		<div id="blog_right">
			<div id="blog_c_right">
				<img src="/images/ajax-loader.gif">
			</div>

			<div id="blog_c_group">
				<img src="/images/ajax-loader.gif">
			</div>
		</div>

		<div id="h_clear"></div>
	</div>

	<div id="h_clear"></div>
</div>

<ERUN360:footer_blog id="footer_blog" runat="server" />

<script language="javascript">

$.get("/Utility/Ajax/UserSummery.aspx", { }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_right").innerHTML = result;
	}
});

$.get("/Utility/Ajax/BlogGroupInfo.aspx", { iduser : <% =u.id %> }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_group").innerHTML = result;
	}
});

function GroupManage()
{
	PopupShow(600, 400, "�������", "/Utility/Include/BlogGroupList.aspx");
	closeCallback = FreshGroups;
}

function UploadImage()
{
	PopupShow(600, 400, "�ϴ�ͼƬ", "<% =HostInfo.imgName %>/utility/include/image.aspx");
	closeCallback = AddFiles;
}

function AddFiles()
{
	$.get("/Utility/Ajax/UpFiles.aspx", { rnd : Math.random() }, function(result) {
		if(result.length > 0) {
			//alert(result);
			var ru = result.split(",");
			for(var i=0; i<ru.length; i++) {
				if(ru[i].length>0) {
					var ra = ru[i].split("|");
					document.getElementById("idImage").value += ra[0] + ",";
					insertText(document.getElementById("cContent"),"\n\n[IMG]" + ra[1] + "[/IMG]\n");
				}
			}
			/*
			var ra = result.split("|");
			document.getElementById("idImage").value = ra[0];
			insertText(document.getElementById("cContent"),"\n\n[IMG]" + ra[1] + "[/IMG]\n");
			*/
		}
	});
}

function FreshGroups()
{
	$.get("/Utility/Ajax/BlogGroup.aspx", { rnd : Math.random() }, function(result) {
		if(result.length > 0) {
			document.getElementById("mygroups").innerHTML = result;
		}
	});
}

</script>

</center>
</body>
</html>
