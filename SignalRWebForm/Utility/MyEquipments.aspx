<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyEquipments.aspx.cs" Inherits="_Utility_MyEquipments" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><% =onwer.cLoginName %>的装备-ERUN360.COM</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/Style.css" rel="stylesheet" type="text/css"/>
<link href="/Common/Blog.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<center>

<ERUN360:header_blog id="header_blog" runat="server" />

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

</center>
</body>
</html>

