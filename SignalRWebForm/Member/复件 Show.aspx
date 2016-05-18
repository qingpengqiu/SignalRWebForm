<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Show.aspx.cs" Inherits="_Utility_Member_Show" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><% =onwer.cLoginName %>����ϸ��Ϣ-ERUN360.COM</title>
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
		<div id="blog_title" class="blog_title1">
			<font style="font-size:24px;"><% =onwer.cLoginName %></font><br>
			<% =PageUser %><br>
			<a href="<% =UrlHelper.MemberUrl(onwer.id) %>" style="color:#000000;">http://www.erun360.com<% =UrlHelper.MemberUrl(onwer.id) %></a><br>
			<div id="blog_guide">
				<% =PageGuide %>
			</div>
		</div>
	</div>

	<div id="blog_c">
		<div id="blog_c_left">

			<div id="blog_m_top"></div>
			<div id="blog_m_mid">

				<!-- ��Ϣ��ʼ -->
				<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
				<tr>
					<td align="right" valign="top">��¼����</td>
					<td><% =record.cLoginName.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">�Ա�</td>
					<td><% =record.idGender.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">�������ڣ�</td>
					<td><% =record.dBirthday.ToString("yyyy-MM-dd") %></td>
				</tr>
				<tr>
					<td align="right" valign="top">ͷ��URL��</td>
					<td><img src="<% =record.cAvatar.ToString() %>"></td>
				</tr>
				<tr>
					<td align="right" valign="top">��飺</td>
					<td><% =record.cBio.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">������</td>
					<td><% =record.cName.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">֤�����ͣ�</td>
					<td><% =record.idNationIdType.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">֤�����룺</td>
					<td><% =record.cNationID.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">�ֻ���</td>
					<td><% =record.cMobile.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">���䣺</td>
					<td><% =record.cMail.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">�ʱࣺ</td>
					<td><% =record.cZipcode.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">��ַ��</td>
					<td><% =record.cAddress.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">���б��룺</td>
					<td><% =record.idCity.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">���ڳ��У�</td>
					<td><% =record.cCityname.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">Ѫ�ͣ�</td>
					<td><% =record.idBlood.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">ְҵ��</td>
					<td><% =record.idOccupation.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">���ѧ����</td>
					<td><% =record.idEducation.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">��Ȥ���ã�</td>
					<td><% =record.cInterests.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">������ϵ��ʽ��</td>
					<td><% =record.cEmergerContact.ToString() %></td>
				</tr>
				<tr>
					<td align="right" valign="top">�������⣺</td>
					<td><% =record.idQuestion.ToString() %></td>
				</tr>
				</table>

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

$.get("/Utility/Ajax/UserSummery.aspx", { rnd : Math.random(), iduser: <% =onwer.id %> }, function(result) {
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
	$.get("/Utility/Ajax/FocusCreate.aspx", { id : idx, checksum : chk }, function(result) {
		if(result == "OK") {
			document.getElementById("focus").innerHTML = "<div class=\"v2a\"  onclick=\"FocusErase(" + idx + ",'" + chk + "')\">- ȡ����ע</a>";
		}
		else { document.getElementById("focus").innerHTML = result; }
	});
}

function FocusErase(idx, chk)
{
	$.get("/Utility/Ajax/FocusErase.aspx", { id : idx, checksum : chk }, function(result) {
		if(result == "OK") {
			document.getElementById("focus").innerHTML = "<div class=\"v1a\"  onclick=\"FocusCreate(" + idx + ",'" + chk + "')\">+ ��ע</a>";
		}
		else { document.getElementById("focus").innerHTML = result; }
	});
}

BindCapture();

</script>

</center>
</body>
</html>
