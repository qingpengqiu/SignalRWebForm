<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Password.aspx.cs" Inherits="_Member_Password" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>设置新密码</title>
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
	<link href="/Common/Calendar.css" rel="stylesheet" type="text/css"/>
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
<script type="text/javascript" src="/Common/jPopupfbk.js"></script>
<script type="text/javascript" src="/Html/js/action.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jPopup.js"></script>
</head>
<body>
<div class="rebox">
    <div class="mediaretop">
        <a href="/" class="reindex">返回首页</a>
    </div>
    <div class="retop">
        <a href="/" class="rlogo">
            <img src="/Html/images/logo.png" alt=""></a>
    </div>
    <div class="refrome oldsavepasswd">
		<form id="form1" name="form1" action="Password.aspx" method="post" autocomplete="off">
            <div class="newregist">
            	<input type="password" id="cPassword" name="cPassword" placeholder="新密码" onblur="if(NullCheck(this)) if(LengthCheck(this,6,32)) StringCheck(this);"> 
            	<div class="Validform_checktip" id="check_cPassword"></div>
            </div>
            <div class="newregist">
            	<input type="password" id="cPassword2" name="cPassword2" placeholder="重复密码" onblur="if(NullCheck(this)) if(LengthCheck(this,6,32)) if(StringCheck(this)) SameCheck(this,'cPassword');" onchange="UpdateHistory2('cPassword')"> 
            	<div class="check_cPassword2"></div>
            </div>
            <input type="hidden" id="idUser" name="idUser" value="<% =iduser %>">
			<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
            <div id="total_echo" ><% =PageResult %></div>
            <a id="register" onclick="Finish()">修改密码</a>
        </form>
    </div>
</div>
<script language="javascript">
function verifyAll()
{
	var check_num = 2;
	var obj = $("#cPassword")[0];
	if(NullCheck(obj)) if(LengthCheck(obj,6,32)) if(StringCheck(obj)) { check_num--; }
	obj = $("#cPassword2")[0];
	if(NullCheck(obj)) if(LengthCheck(obj,6,32)) if(StringCheck(obj)) if(SameCheck(obj,'cPassword')) { check_num--; }
    return (check_num == 0) ? true : false;
}
function Finish()
{
	var hv = $("#UpdatedFields")[0].value;
	if(verifyAll() && hv.length > 0)
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
<ERUN360:footerv3 runat="server" ID="footerv3" />