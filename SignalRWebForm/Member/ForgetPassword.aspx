﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgetPassword.aspx.cs" Inherits="infocenter_ForgetPassword" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title></title>
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
        <a href="/" class="reindex">返回首页</a> <a href="/Member/Login.aspx" class="relogin">登录</a>
    </div>
    <div class="retop">
        <a href="/" class="rlogo">
            <img src="/Html/images/logo.png" alt=""></a>
        <span>已经是益跑网注册会员 <a href="/Member/Login.aspx">登录</a></span>
    </div>
    <div class="refrome refi">
        <form id="form">
            <input type="hidden" value="forgetpass" name="op" id="op">
            <input type="hidden" value="forgetpass" name="loginname" id="loginname">
            <div class="newregist">
                <input type="text" placeholder="手机号" value="<%=loginame%>" name="mobile" id="mobile" class="ajaxve" data-op="verifymobile" data-get="0"><div class="Validform_checktip getname">只能使用手机</div>
            </div>
            <div class="newregist">
                <input type="text" name="txtCode" id="txtCode"  value=""  class="ajaxve m80" data-op="verificationcode" data-get="0" placeholder="图形验证码" /><div class="rcodebox"><img src="/Member/limg.aspx" id="vimg" class="vimg" onclick="change()"/><a onclick="change()" href="javascript:void(0)" class="rloadcode"><i>换一张</i></a></div><div class="Validform_checktip"></div>
            </div>
            <div class="newregist">
                <input type="text" name="msgCode" id="msgCode"  value=""  class="ajaxve m80" data-op="msgcode" data-get="0" placeholder="短信验证码" disabled /><a class="getmsgcode" data-get="0" href="javascript:void(0)">获取短信校验码</a><div class="Validform_checktip"></div>
            </div>
            <div class="newregist">
                <input type="password" value="" name="newpass" id="newpass" class="ajaxve" data-op="verifynewpass" ><div class="Validform_checktip">新密码</div>
            </div>
            <a id="ensure" href="javascript:void(0)">确定</a>
        </form>
    </div>
</div>
<script type="text/javascript">
var name = GetQueryString('name')
$("#loginname").val(encodeURI(name))
if (!/^[0-9]*$/.test(name)) {
    $(".getname").html('您的手机号为<%=mobile%>')
}else{
    $("#mobile").val(name)
}
$.ajaxSetup({
    error:function(x,e){
            // $(".toast").html('网络错误').show().removeClass('toast-success').addClass('toast-error')
            errorboxhide()
        return false;
    }
});
$(".ajaxve").blur(function(event) {
        var op = $(this).data("op"),
            code = $(this).val(),
            loginname = $("#loginname").val(),
            mobile = $("#mobile").val(),
            newpass = $("#newpass").val(),
            t = $(this)
        if (op == "verificationcode" && $("#mobile").data('get') == 0) {
                    $("#mobile").focus();
            };
        switch(op)
        {
            case 'verifymobile':
                var url = '/action/ChangeMobile.ashx?op=' + op + '&loginname='+loginname+'&mobile=' + mobile
                break;
            case 'verificationcode':
                var url = '/action/ChangeMobile.ashx?op=' + op +'&code=' + code
                break;
            case 'msgcode':
                var url = '/action/ChangeMobile.ashx?op=' + op + '&msgtype=forgetpwd&code=' + code + '&mobile=' + mobile
                break;
            case 'verifynewpass':
                var url = '/action/ChangeMobile.ashx?op=' + op + '&newpass=' + code 
                break;
        }
        $.get(url, function (data) {
            if (data.status == 1) {
                if (op == 'verificationcode') {
                    $(".getmsgcode").addClass('gomsgcode').data('get', '1')
                };
                t.data('get', '1')
                t.addClass('rightlogin').removeClass('errorlogin').nextAll('.Validform_checktip').html(data.msg)
            }else{
                t.addClass('errorlogin').removeClass('rightlogin').nextAll('.Validform_checktip').html(data.msg)
                $(".toast").html(data.msg).show().removeClass('toast-success').addClass('toast-error')
                errorboxhide()
            }
        });
        return false
        $.get('/action/ChangeMobile.ashx?op=' + op + '&code=' + code+ '&mobile=' + code+ '&loginname='+loginname+ '&newpass='+newpass, function (data) {
        if (data.status == 1) {
            if (op == 'verificationcode') {
                $(".getmsgcode").addClass('gomsgcode').data('get', '1')
            };
            t.data('get', '1')
            t.addClass('rightlogin').removeClass('errorlogin').nextAll('.Validform_checktip').html(data.msg)
        }else{
            t.addClass('errorlogin').removeClass('rightlogin').nextAll('.Validform_checktip').html(data.msg)
            $(".toast").html(data.msg).show().removeClass('toast-success').addClass('toast-error')
                errorboxhide()
        }
    });
});
$(".getmsgcode").click(function(event) {
    $("#msgCode").focus();
    if ($(this).data("get") == 1 || $(this).data("get") == 3) {
        $("#msgCode").removeAttr('disabled')
        var mobile = $("#mobile").val(),
            code = $("#txtCode").val()
        $.get('/action/ajaxsms.ashx?op=sendsms&type=forgetpwd&mobile=' + mobile + '&code=' + code, function (data) {
            if (data.status == 1) {
                $(".getmsgcode").removeClass('gomsgcode').data('get', '2')
                $(".toast").html(data.msg).show().removeClass('toast-error').addClass('toast-success')
                errorboxhide()
                var s = 60,
                ds = setInterval(function(){
                    if(s == 0){
                        $(".getmsgcode").addClass('gomsgcode').data('get', '3').html('重新获取校验码')
                        clearInterval(ds)
                        return false
                    }
                    $(".getmsgcode").html(s+'秒后重新发送')
                    s--
                },1000);
            }else{
                $(".toast").html(data.msg).show().removeClass('toast-success').addClass('toast-error')
                errorboxhide()
            }
        });
    };
});


function change() {
    var imgNode = document.getElementById("vimg");
    imgNode.src = "/Member/limg.aspx?t=" + (new Date()).valueOf();
}
$("#ensure").click(function (event) {
    var go = 1
    $(".refi input").each(function(index, el) {
        if (!$(this).val()) {
            $(this).focus()
            go = 0
            return false
        }else if($(this).hasClass('errorlogin')){
            $(this).focus()
            go = 0
            return false
        }
    }); 
    if (go == 1) {
        var postdata = $("#form").serialize()
        $.post('/action/ChangeMobile.ashx', postdata, function (data, textStatus, xhr) {
            if (data.status == 1) {
                $(".toast").html(data.msg).show().addClass('toast-success')
                setTimeout(function() {
                    window.location.href="/"; 
                }, 2000)
            }
            else {
                $(".toast").html(data.msg).show().addClass('toast-error')
            }
            errorboxhide()
        });
        
    };
});
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />