﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Member_Register" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>注册成为益跑网会员</title>
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
        <span>已经是益跑网注册会员,返回首页 <a href="/?a=login">登录</a></span>
    </div>
    <div class="refrome refi">
        <form id="form">
            <input type="hidden" value="Register" name="op" id="op">
            <div class="registtoptip">注册帐号</div>
            <div class="newregist">
                <input type="text" placeholder="手机号" value="" name="loginCode" id="loginCode" class="ajaxve" data-op="loginname" data-get="0"><div class="Validform_checktip">只能使用手机号</div>
            </div>
            <div class="newregist">
                <input type="text" name="txtCode" id="txtCode"  value=""  class="ajaxve m80" data-op="loginCode" data-get="0" placeholder="图形验证码" /><div class="rcodebox"><img src="limg.aspx" id="vimg" class="vimg" onclick="change()"/><a onclick="change()" href="javascript:void(0)" class="rloadcode"><i>换一张</i></a></div><div class="Validform_checktip"></div>
            </div>
            <div class="newregist">
                <input type="text" name="msgCode" id="msgCode"  value=""  class="ajaxve m80" data-op="msgcode" data-get="0" placeholder="短信验证码" disabled/><a class="getmsgcode" data-get="0" href="javascript:void(0)">获取短信校验码</a><div class="Validform_checktip"></div>
            </div>
            <div class="newregist">
                <input type="text" placeholder="站内显示的名字" value="" name="txtNick" id="txtNick" class="ajaxve" data-op="loginnick" data-get="0"><div class="Validform_checktip">站内显示的名字</div>
            </div>
            <div class="newregist">
                <input type="password"  value="" name="txtPassWord" id="txtPassWord" class="passwd" placeholder="密码" ><div class="Validform_checktip">密码至少6个字,最多18个字</div>
            </div>
            <div class="newregist agnewregist">
                <input id="agree" type="checkbox" name="agree" checked="checked"><label for="agree">我已经看过并同意 <a href="/channels/about/lawyer.aspx" target="_blank" class="agree">《益跑网服务使用协议》</a></label>
            </div>
            <a id="register">立即注册</a>
            <div class="mediatip">已经是益跑网注册会员,请<a href="/?a=login">返回首页登录</a></div>
        </form>
    </div>
</div>
<script type="text/javascript">
// $.ajaxSetup({
//     timeout: 3000,
//     error:function(x,e,c){
//         console.log(x)
//         console.log(e)
//         console.log(c)
//              $(".toast").html('网络错误').show().removeClass('toast-success').addClass('toast-error')
//             errorboxhide()
//         return false;
//     }
// });
$(".ajaxve").blur(function(event) {
    var op = $(this).data("op"),
        code = $(this).val(),
        t = $(this)
        if (op == "loginCode" && $("#loginCode").data('get') == 0) {
                $("#loginCode").focus();
                $(".toast").html('请先填正确的写手机号').show().removeClass('toast-error').addClass('toast-error')
                errorboxhide()
                return false
        };
        if (op == 'msgcode') {
            if ($(".getmsgcode").data('get') == 1 || $(".getmsgcode").data('get') == 0) {
                return false
            }else{
                var mobile = $("#loginCode").val()
                $.get('/action/LoginHandler.ashx?op='+op+'&type=register&code='+code+'&mobile='+mobile, function(data) {
                    data  = JSON.parse(data);
                    if (data.status == 1) {
                        if (op == 'loginCode') {
                            $(".getmsgcode").addClass('gomsgcode').data('get', '1')
                        };
                        t.data('get', '1')
                        t.addClass('rightlogin').removeClass('errorlogin').nextAll('.Validform_checktip').html(data.msg)
                    }else{
                        t.addClass('errorlogin').removeClass('rightlogin').nextAll('.Validform_checktip').html(data.msg)
                        $(".toast").html(data.msg).show().removeClass('toast-success').addClass('toast-error')
                        errorboxhide()
                    }
                },function(error){
                    console.log(11)
                });
                return false
            }
        };
    $.get('/action/LoginHandler.ashx?op='+op+'&type=register&code='+code, function(data) {
        if (data.status == 1) {
            if (op == 'loginCode') {
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
        var tel = $("#loginCode").val(),
            code = $("#txtCode").val()
        $.get('/action/ajaxsms.ashx?op=sendsms&type=register&mobile=' + tel + '&code=' + code, function (data) {
            if (data.status == 1) {
                $("#msgCode").removeAttr('disabled')
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
// $(".passwd").blur(function(event) {
//     var p1 = $("#txtPassWord").val(),
//         p2 = $("#txtPassWord2").val(),
//         t = $(this)
//         if (!t.val()) {
//             t.addClass('errorlogin')
//         }else{
//             if (t.val().length < 6) {
//                 t.addClass('errorlogin').next('.Validform_checktip').html('密码不小于6位')
//                 return false
//             }else{
//                 t.next('.Validform_checktip').html('')
//             }
//             t.removeClass('errorlogin')
//             if (p1 == p2) {
//                 $(".passwd").removeClass('errorlogin').addClass('rightlogin')
//             }else{
//                 if ( p1 && p2) {
//                     t.addClass('errorlogin')
//                     $(".toast").html('两次密码不一样').show().removeClass('toast-success').addClass('toast-error')
//                     errorboxhide()
//                 };
//             }
//         }
// });
$(".passwd").blur(function(event) {
    var p1 = $("#txtPassWord").val()
        t = $(this)
        if (!t.val()) {
            t.addClass('errorlogin')
        }else{
            if (t.val().length < 6) {
                t.addClass('errorlogin').next('.Validform_checktip').html('密码不小于6位')
                return false
            }else{
                t.next('.Validform_checktip').html('')
            }
            t.removeClass('errorlogin')
        }
});
function change() {
    var imgNode = document.getElementById("vimg");
    imgNode.src = "limg.aspx?t=" + (new Date()).valueOf();
}
$("#register").click(function(event) {
    var go = 1
    if (!$("#agree").is(':checked')) {
        alert('请同意益跑网服务使用协议')
        return false
    };
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
        var resize = $("#form").serialize()
        $.post('/action/ajaxsms.ashx', resize, function(data, textStatus, xhr) {
            if (data.status == 1) {
                $(".toast").html(data.msg).show().addClass('toast-success')
                $.AMUI.store.set('userinfo',data)
                setTimeout(function() {
                    window.location.href="/Member/register1.aspx"; 
                }, 2000)
            }else{
                $(".toast").html(data.msg).show().addClass('toast-error')
            }
            errorboxhide()
        });
        
    };
});
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />