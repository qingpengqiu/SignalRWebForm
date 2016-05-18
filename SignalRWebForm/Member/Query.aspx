<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="_Member_Query" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>��������</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="/assets/i/favicon.png">
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="/assets/css/blueimp-gallery.min.css">
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" href="/Html/css/marathon.css">
    <link rel="stylesheet" type="text/css" href="/Html/css/infocenterv3.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/indexv3.css" />
    <link href="/Html/css/register.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/registmedia.css" />
</head>
<body>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/assets/js/jquery.min.js"></script>
<script src="/assets/js/jquery.mobile.custom.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="/assets/js/jquery.min.js"></script>
<script src="/assets/js/modernizr.js"></script>
<script src="/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/assets/js/amazeui.min.js"></script>
<script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
<script type="text/javascript" src="/Html/js/action.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
</head>
<body>
<div class="rebox">
    <div class="mediaretop">
        <a href="/" class="reindex">������ҳ</a>
    </div>
    <div class="retop">
        <a href="/" class="rlogo">
            <img src="/Html/images/logo.png" alt=""></a>
        <span>��������,������ҳ <a href="/">��¼</a></span>
    </div>
    <div class="refrome oldcheckpasswd">
		<form id="form1" name="form1" action="Query.aspx" method="post" autocomplete="off">
			<div class="zclxa">
	��������������ʾ���⡢��½�˺����ƻ����������Ϣ���뽫�������֤ɨ�����������ɣ��������������¼������Ŀһ�������� <a href="mailto:info@erun360.com">info@erun360.com</a> ������������ϵ��ʽ�����ǻ���3���������ڽ��к�ʵ���ɺ�̨�ָ�����ʼ���룬��ɺ�����������ϵ��֪��лл
</div>
            <div class="newregist">
            	<input type="text" id="cName" name="cName" placeholder="����" onblur="if(NullCheck(this)) if(LengthCheck(this,2,16)) StringCheck(this);"><div class="Validform_checktip" id="check_cName"></div>
            </div>
            <div class="newregist">
            	<% =GCommon.Controls("�Ա�","radio", "idGender", "0") %>
            </div>
            <div class="newregist">
            	<input type="text" id="dBirthday" name="dBirthday" data-am-datepicker="{theme: 'success'}" placeholder="����">
            	<div class="Validform_checktip">����</div>
            </div>
            <div class="newregist">
            	<% =GCommon.Controls("��������","select", "idQuestion", "") %>
            	<input type="text" id="cAnswer" name="cAnswer" placeholder="��" onblur="if(NullCheck(this)) if(LengthCheck(this,3,32)) StringCheck(this);"> 
            	<div class="Validform_checktip" id="check_cAnswer">��������+��</div>
            </div>
            <input name="UpdatedFields" type="hidden" id="UpdatedFields" />
            <div id="total_echo" ><% =PageResult %></div>
            <a id="register" onclick="Finish()">�һ�����</a>
            <div class="mediatip">�������� <a href="/">������ҳ��¼</a></div>
        </form>
    </div>
</div>
<script language="javascript">
function verifyAll()
{
	var check_num = 2;
	var obj = $("#cName")[0];
	if(NullCheck(obj)) if(LengthCheck(obj,2,16)) if(StringCheck(obj)) { check_num--; }
	obj = $("#cAnswer")[0];
	if(NullCheck(obj)) if(LengthCheck(obj,4,32)) if(StringCheck(obj)) { check_num--; }
    return (check_num == 0) ? true : false;
}
function Finish()
{
    if(verifyAll())
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
<ERUN360:footerv3 runat="server" ID="footerv3" />