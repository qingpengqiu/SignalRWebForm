<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceHistory.aspx.cs" Inherits="_Utility_RaceHistory" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><% =onwer.cLoginName %>训练记录</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta name="distribution" content="global" />
<link href="/Common/Style.css" rel="stylesheet" type="text/css"/>
<link href="/Common/Blog.css" rel="stylesheet" type="text/css"/>
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

				<form id="searchFrm" name="searchFrm" action="/Utility/Racehistory.aspx" method="post" >
				<table id="tableCreate" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr> 
					<td style="color:#666666;font-size:12px;width:120px;" nowrap align="right"> 
					</td>
					<td style="color:#666666;font-size:12px;" nowrap align="left"> 
						<% =GCommon.HMS("year", 2012, 2020, DateTime.Now.Year) %>
						<% =GCommon.HMS("month", 1, 12, DateTime.Now.Month) %>
						<% =GCommon.HMS("day", 1, 31, DateTime.Now.Day) %>
					</td>
				</tr>
				<tr> 
					<td style="color:#666666;font-size:12px;width:120px;" nowrap align="right"> 
						我跑了：
					</td>
					<td style="color:#666666;font-size:12px;" nowrap align="left"> 
						<% =GCommon.Controls("","select","idRoadStyle", "0") %>
						<input type="text" name="iDistance" id="iDistance" size="3" maxlength="3" class="input_cls1" value="" onmouseover="this.className='input_cls2';" onmouseout="this.className='input_cls1';" onblur="this.className='input_cls1';">公里(整数,小于100公里)
					</td>
				</tr>
				<tr> 
					<td style="color:#666666;font-size:12px;" nowrap align="right"> 
						用时：
					</td>
					<td style="color:#666666;font-size:12px;" nowrap align="left"> 
						<% =GCommon.HMS("iHours", 0, 24, 0) %> 时 
						<% =GCommon.HMS("iMinutes", 0, 59, 0) %> 分 
						<% =GCommon.HMS("iSeconds", 0, 59, 0) %> 秒 
					</td>
				</tr>
				<tr> 
					<td style="color:#666666;font-size:12px;" nowrap align="right"> 
						装备：
					</td>
					<td style="color:#666666;font-size:12px;" nowrap align="left"> 
						<input type="text" name="cEquipment" id="cEquipment" size="32" maxlength="32" class="input_cls1" value="" onmouseover="this.className='input_cls2';" onmouseout="this.className='input_cls1';" onblur="this.className='input_cls1';">
					</td>
				</tr>
				<tr> 
					<td style="color:#666666;font-size:12px;" nowrap align="right"> 
						心得：
					</td>
					<td style="color:#666666;font-size:12px;" nowrap align="left"> 
						<input type="text" name="cMemo" id="cMemo" size="64" maxlength="128" class="input_cls1" value="" onmouseover="this.className='input_cls2';" onmouseout="this.className='input_cls1';" onblur="this.className='input_cls1';">
					</td>
				</tr>
				<tr> 
					<td></td>
					<td nowrap align="left"><img src="/images/submit-small.gif" onclick="document.searchFrm.submit();return true;"><% =PageResult %></td>
				</tr>
				</table>
				</form>	
			</div>

			<div id="blog_k_bot"></div>
			<div id="blog_k_spc"></div>

			<div id="blog_m_top"></div>
			<div id="blog_m_mid">
				
				<span id="formSpan"></span>
				<% =PageEcho %>

				<% =PageBuffer %>

				<div style="width:675px;height:30px;text-align:right;padding-top:20px;padding-right:10px;">
					<% =PageNext %>
				</div>

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


function RcDelete(idx,pos,chk)
{
   if (confirm("确定要删除这个训练记录吗？") == true)
   {
      $.get("/Utility/Ajax/RcDelete.aspx" , { id : idx, checksum : chk }, function(result) { 
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

</script>

</center>
</body>
</html>

