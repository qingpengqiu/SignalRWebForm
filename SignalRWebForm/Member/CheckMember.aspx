<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CheckMember.aspx.cs" Inherits="Member_CheckMember" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>忘记密码</title>
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
<script type="text/javascript" src="/Common/jPopupfbk.js"></script>
<script type="text/javascript" src="/Html/js/action.js"></script>
</head>
<body>
<div class="rebox">
    <div class="mediaretop">
        <a href="/" class="reindex">返回首页</a>
    </div>
    <div class="retop">
        <a href="/" class="rlogo">
            <img src="/Html/images/logo.png" alt=""></a>
        <span>想起密码,返回首页 <a href="/">登录</a></span>
    </div>
    <div class="refrome checkpasswd">
        <input type="hidden" value="Register" name="op" id="op">
        <div class="registtoptip">输入登录名找回密码</div>
        <div class="newregist">
            <input type="text" placeholder="登录名" value="" name="loginCode" id="loginCode" ><div class="Validform_checktip">输入登录名找回密码</div>
        </div>
        <a id="register">找回密码</a>
        <div class="mediatip">想起密码 <a href="/">返回首页登录</a></div>
    </div>
</div>
<script type="text/javascript">
    $("#register").click(function(event) {
        $.get('/action/changeMobile.ashx?op=checkmember&loginname='+$("#loginCode").val(), function(data) {
            if (data.status == 0) {
                $(".toast").html(data.msg).show().removeClass('toast-error').addClass('toast-error')
            }else{
                var name = $("#loginCode").val()
                if (data.msg == 1) {
                    window.location.href = "/Member/forgetpassword.aspx?name="+encodeURI(encodeURI(name))
                }else{
                    window.location.href = "/Member/Query.aspx"
                }
            }
            console.log(data)
                errorboxhide()
        });
    });
    $('#loginCode').bind('keypress', function (event) {
        if (event.keyCode == "13") {
            $("#register").click();
        }
    });

</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />