<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Success.aspx.cs" Inherits="_Member_Success" %>
<html>
<head>
<title>ע��ɹ�-ERUN360.COM</title>
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
<div style="width:950px;height:583px;background-image:url(/images/user-back4.gif);">
	<div id="page_nav" style="height:22px;padding-left:30px;padding-top:20px;">
		<a href="/">��ҳ</a> >
		<a href="/Member/">��Ա����</a> > 
		��¼�ɹ�
	</div>
<style>
#blog_right { float:right;width:220px;height:600px; }
#blog_c_right { float:right;width:220px; }
#blog_d_top { float:left;width:220px;height:12px;font-size:1px;line-height:0px;background-image:url(/images/blog/bk-right1.gif);background-repeat:no-repeat; }
#blog_d_mid { float:left;width:220px;background-image:url(/images/blog/bk-right3.gif);text-align:center;padding-top:20px; }
#blog_d_usr { width:180px;padding:20px;font-size:12px;text-align:left; }
#blog_d_usr a { color:#4C98CC;font-size:12px; }
#blog_d_usr_line { height:20px; }
#blog_d_usr_item { background-image:url(/images/blog/icons.gif);background-repeat:no-repeat;width:145px;height:17px;padding-left:25px;font-size:12px; }
#blog_d_group { float:left;width:160px;padding:20px;padding-top:0px;font-size:12px;text-align:left;line-height:20px;white-space:nowrap;overflow:hidden; }
#blog_d_group a { color:#4C98CC;font-size:12px; }
#blog_d_clear { clear:both;width:220px;height:1px; }
#blog_d_bot { float:left;width:220px;height:15px;font-size:1px;line-height:0px;background-image:url(/images/blog/bk-right2.gif);background-repeat:no-repeat; }
#pageContent{float:left;width:638px;padding-left:30px;text-align:left;}
.grxx{border:dotted 1px #CCCCCC;padding:20px;font-family: Microsoft YaHei;color: #666;}
.grxx b{color: #333;font-size: 16px;}
.grxx a{color: #666;line-height: 25px;font-size: 14px;}
.grxx a:hover{color: #fd6b01}
.grright{float:right;width:220px;height:380px;padding:20px;padding-top:0px;text-align:left;font-size:12px;line-height:20px;}
.footer_w {width: 970px; color: #666;  font-size: 12px;  line-height: 25px;  padding: 15px 0 35px; text-align: center;margin: 11px auto ; border-top: 1px solid #cccccc
}
</style>	
	<div id="pageContent" >	
		<div class="grxx">
			<b>������Ϣ��ز�����</b><br>
			<br>
			&bull; <a href="/Member/Personal.aspx">������Ƹ���ע����Ϣ��������Ϣ�������ѯ����ϵ��ʽ�ȣ�</a><br>
			&bull; <a href="/Member/Size.aspx">�������������Ϣ</a><br>
			&bull; <a href="/Member/Photo.aspx">�ϴ��޸�ͷ��</a><br>
			<br>
			&bull; <a href="/Member/Password.aspx">�޸�����...</a><br>
			&bull; <a href="/Member/Logout.aspx">�˳���¼...</a><br>
		</div>
		<br>
		<div class="grxx">
			<b>������ز�����</b><br>
			<br>
			&bull; <a href="<% =UrlHelper.MemberUrl(idUser) %>">�ҵ���ҳ</a><br>
			&bull; <a href="/Utility/Member.aspx">�ҵĲ���</a><br>
			&bull; <a href="<% =UrlHelper.GalleryUrl(idUser) %>">�ҵ����(COOL!)</a><br>
			&bull; <a href="/Utility/Write.aspx">������,Լ��,�ܲ����ֲ�</a><br>
		</div>
		<br>
		<% =PageAdmin %>
		<br>
	</div>
	<div class="grright">
		<div id="blog_c_right">
			<img src="/images/ajax-loader.gif">
		</div>
	</div>
</div>
<script language="javascript">
$.get("/Utility/Ajax/UserSummery.aspx", { }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_right").innerHTML = result;
	}
});
</script>
<ERUN360:footer_user id="footer_user" runat="server" />
</center>
</body>
</html>