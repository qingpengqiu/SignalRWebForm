<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyRace.aspx.cs" Inherits="_Utility_MyRace" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><% =onwer.cLoginName %>的约跑-ERUN360.COM</title>
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

<div id="blog_b">
	<div id="blog_b_1">
		<% =PageFace %>
		<div id="blog_title" class="blog_title1">
			<font style="font-size:24px;"><% =onwer.cLoginName %></font><br>
			<% =PageUser %><br>
			<a href="<% =UrlHelper.MemberUrl(onwer.id) %>">http://www.erun360.com<% =UrlHelper.MemberUrl(onwer.id) %></a><br>
			<div id="blog_guide">
				<% =PageGuide %>
			</div>
		</div>
	</div>

	<div id="blog_c">
		<div id="blog_c_left">
			<div id="blog_k_top"></div>
			<div id="blog_k_mid" >
				<form id="frmRace" name="frmRace" action="MyRace.aspx" method="post">
				<table>
				<tr>
					<td>
					</td>
					<td>
						搜索约跑活动
					</td>
				</tr>
				<tr>
					<td>
						所在城市：
					</td>
					<td>
						<script type="text/javascript" src="/Common/jCity.js"></script>
						<div style="float:left;width:130px;height:28px;border:solid 1px #CCCCCC;background-color:#FFFFFF;padding:3px;margin-right:10px;">
						<select  name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)">
						</select>
						</div>
						<div style="float:left;width:130px;height:28px;border:solid 1px #CCCCCC;background-color:#FFFFFF;padding:3px;margin-right:10px;">
						<select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
						</select>
						</div>
						<script type="text/javascript" language ="javascript">
						<!--
							BindProvince("北京");
						// -->
						</script>
						<input type="hidden" id="idCity" name="idCity" size="5" readonly value="" onchange="UpdateHistory(this)">
						<input type="hidden" id="cCityname" name="cCityname" size="16" readonly value="" onchange="UpdateHistory(this)">						
					</td>
				</tr>
				<tr>
					<td>
						活动类别：
					</td>
					<td>
						<% =GCommon.Controls("活动类别", "select", "idRoadStyle", "") %>
					</td>
				</tr>
				<tr>
					<td>
						时间：
					</td>
					<td>
						<input type="text" id="date1" name="date1" size="20" maxlength="255"  readonly value="<% =DateTime.Now.ToString("yyyy-MM-dd") %>" onclick="GDate(this);" style="background-color:#E0E0E0;cursor:pointer;"> 至  
						<input type="text" id="date2" name="date2" size="20" maxlength="255"  readonly value="<% =DateTime.Now.ToString("yyyy-MM-dd") %>" onclick="GDate(this);" style="background-color:#E0E0E0;cursor:pointer;">
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
					</td>
					<td>
						<img src="/images/submit.gif" onclick="Finish()">
					</td>
				</tr>
				</table>
				</form>

<script type="text/javascript" language ="javascript">
<!--

function Finish()
{
	if(document.getElementById("idCity").value.length < 1)
	{
		alert("请选择所在城市和区域!");
		return false;
	}

	document.frmRace.submit();
	return true;
}

// -->
</script>

			</div>

			<div id="blog_k_bot"></div>
			<div id="blog_k_spc"></div>

			<% =PageBuffer %>

		</div>
		
		<!--右侧用户信息-->
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

$.get("/Utility/Ajax/UserSummery.aspx", { iduser: <% =onwer.id %> }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_right").innerHTML = result;
	}
});


$.get("/Utility/Ajax/BlogGroupInfo.aspx", { iduser : <% =onwer.id %> }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_group").innerHTML = result;
	}
});

function FocusCreate(idx, chk)
{
	var objname =  idx + "A";
	objname = (objname.substr(0,1)=="1") ? "focus" : "blog_info_left";
	$.get("/Utility/Ajax/FocusCreate.aspx", { id : idx, checksum : chk }, function(result) {
		if(result == "OK") {
			document.getElementById(objname).innerHTML = "<div class=\"v2a\"  onclick=\"FocusErase(" + idx + ",'" + chk + "')\">- 取消关注</a>";
		}
		else { document.getElementById(objname).innerHTML = result; }
	});
}

function FocusErase(idx, chk)
{
	var objname =  idx + "A";
	objname = (objname.substr(0,1)=="1") ? "focus" : "blog_info_left";
	$.get("/Utility/Ajax/FocusErase.aspx", { id : idx, checksum : chk }, function(result) {
		if(result == "OK") {
			document.getElementById(objname).innerHTML = "<div class=\"v1a\"  onclick=\"FocusCreate(" + idx + ",'" + chk + "')\">+ 关注</a>";
		}
		else { document.getElementById(objname).innerHTML = result; }
	});
}

function BlogEdit(idx)
{
	window.location = "/Utility/BlogUpdate.aspx?id=" + idx;
}

function BlogDelete(pos,idx,chk)
{
   if (confirm("确定要删除这个博客吗？") == true)
   {
      $.get("/Utility/Ajax/BlogDelete.aspx" , { id : idx, checksum : chk }, function(result) { 
         if(result == "OK")
         {
             $("#blog_total_" + pos).html("");
         }
         else
         {
             alert(result);
         }
      });
   }
}

</script>
<script language="javascript" src="/Common/jImage.js"></script>

</center>
</body>
</html>
