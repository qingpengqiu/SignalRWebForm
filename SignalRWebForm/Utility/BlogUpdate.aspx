<%@ Page Language="C#" AutoEventWireup="true" validateRequest="false" CodeFile="BlogUpdate.aspx.cs" Inherits="_Utility_BlogUpdate" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>编辑(Blog)</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
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
			<font style="font-size:24px;"><% =u.cLoginName %></font><br>
			<% =u.cBio %><br>
			<a href="<% =UrlHelper.MemberUrl(u.id) %>">http://www.erun360.com<% =UrlHelper.MemberUrl(u.id) %></a><br>
			<div id="blog_guide">
				<div class="v2"><a href="/utility/member.aspx">我的博客</a></div> 
				<div class="v2"><a href="/utility/write.aspx">发博客</a></div>   
			</div>
		</div>
	</div>

	<div id="blog_c">
		<div id="blog_c_left">

			<div id="blog_m_top"></div>

			<div style="width:675px;background-image:url(/images/blog/bk-left2.gif);background-position:-0px -17px;font-size:12px;padding-left:20px;padding-right:20px;padding-top:5px;text-align:center;overflow:hidden;">

				<form id="form1" name="form1" action="BlogUpdate.aspx" method="post">
				<table id="tableCreate" width="600" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
				<tr>
					<td align="right" valign="top" nowrap>标题：</td>
					<td align="left">
						<% =PageExt %><br>
						<input type="text" id="cTitle" name="cTitle" size="72" maxlength="128"  onblur="if(NullCheck(this)) if(StringCheck(this)) LengthCheck(this,2,128);" value="<% =record.cTitle.ToString() %>" onchange="UpdateHistory(this)"> 
					</td>
				</tr>
				<tr>
					<td align="right" valign="top" nowrap>内容：</td>
					<td align="left">
						
						<script language="javascript">var ewidth = 519; </script>
						<script language="javascript" src="/Common/jEditor.js"></script>

						<textarea id="cContent" name="cContent" cols="70" rows="15" onblur="if(NullCheck(this)) StringCheck(this);" onchange="UpdateHistory(this)"><% =record.cContent.ToString() %></textarea>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top" nowrap>发布于：</td>
					<td align="left">
						<% =PageGroups %>
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" id="idImage" name="idImage" value="">
						<input type="hidden" id="id" name="id" value="<% =record.id.ToString() %>">
						<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="cContent">
					</td>
					<td align="left">
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

				<div style="clear:both;width:600px;height:20px;"></div>
			</div>
			<div id="blog_m_bot"></div>
			<div id="blog_m_spc"></div>

<!-- 信息输入相关javascript代码，需jQuery支持 -->
<script language="javascript">

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
		$("#total_echo").html("不行啊！提交数据还有错误哦！");
	}
	return false;
}

function UploadImage()
{
   PopupShow(600, 400, "上传图片", "<% =HostInfo.imgName %>/utility/include/image.aspx");
}

function AddFiles()
{
	$.get("/Utility/Ajax/UpFiles.aspx", { rnd : Math.random() }, function(result) {
		if(result.length > 0) {
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
			UpdateHistory2("cContent");
		}
	});
}
closeCallback = AddFiles;

</script>


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

$.get("/Utility/Ajax/UserSummery.aspx", { iduser: <% =u.id %>}, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_right").innerHTML = result;
	}
});

$.get("/Utility/Ajax/BlogGroupInfo.aspx", { iduser : <% =u.id %> }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_group").innerHTML = result;
	}
});

</script>
</body>
</html>

