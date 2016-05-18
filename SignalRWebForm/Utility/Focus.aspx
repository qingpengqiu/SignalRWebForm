<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Focus.aspx.cs" Inherits="_Utility_Focus" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>我的关注</title>
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
		<%--<% =PageFace %>--%>
		<div id="blog_title" class="blog_title1">
			<font style="font-size:24px;"><% =u.cLoginName %></font><br>
			<% =PageUser %><br>
			<a href="<% =UrlHelper.MemberUrl(u.id) %>">http://www.erun360.com<% =UrlHelper.MemberUrl(u.id) %></a><br>
			<div id="blog_guide">
				<% =PageGuide %>
			</div>
		</div>
	</div>

	<div id="blog_c">
		<div id="blog_c_left">
			<div id="blog_m_top"></div>

			<div style="width:675px;background-image:url(/images/blog/bk-left2.gif);background-position:-0px -17px;font-size:12px;padding-left:20px;padding-right:20px;padding-top:5px;text-align:left;overflow:hidden;">
				<br>
				<a href="/utility/focus.aspx" style="font-size:14px;color:#5C6F9A;text-decoration: underline;">我的粉丝</a> - 
				<a href="/utility/focus.aspx?cmd=me" style="font-size:14px;color:#5C6F9A;text-decoration: underline;">我关注的博主</a> - 
				<a href="/utility/focus.aspx?cmd=blog" style="font-size:14px;color:#5C6F9A;text-decoration: underline;">我关注的博客</a> - 
				<a href="/utility/focus.aspx?cmd=diz" style="font-size:14px;color:#5C6F9A;text-decoration: underline;">给我的留言</a>
				<br>
				<br>
				<% =PageBuffer %>

			</div>

			<div id="blog_m_bot"></div>
			<div id="blog_m_spc"></div>

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

$.get("/Utility/Ajax/UserSummery.aspx", { iduser: <% =u.id %> }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_right").innerHTML = result;
	}
});


$.get("/Utility/Ajax/BlogGroupInfo.aspx", { iduser : <% =u.id %> }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_group").innerHTML = result;
	}
});


function DizDelete(tab, idx, pos, md5)
{
   if (confirm("确定要删除本留言吗？") == true)
   {
      $.get("/utility/ajax/DiscussDelete.aspx" , { idinfo : tab, id : idx, checksum : md5 }, function(result) { 
         if(result == "OK")
         {
             $("#blog_kall_" + pos)[0].style.display = "none";
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

