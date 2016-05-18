<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register5.aspx.cs" Inherits="Member_Register5" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>推荐益跑用户</title>
    <meta name="keywords" content="">
    <meta name="description" content="我们为您推荐的益跑用户，您可以关注并和他们互动^_^" />
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
<body class="registnbg">
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
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="../Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="rebox">
            <div class="retop">
                <a href="" class="rlogo">
                    <img src="/Html/images/tlogo.png" alt=""></a>
            </div>
            <div class="retju">
                <h3>我们为您推荐的益跑用户，您可以关注并和他们互动^_^</h3>
                <div class="retjtitle">
                    <a href="/Member/Register5.aspx">[ 换一组 ]</a>
                </div>
                <div class="blog focus">
                    <ul class="">
                        <%=StrRecom %>
                    </ul>
                </div>
                <div class="bottom">
                    <asp:Button ID="renext" runat="server" Text="完成注册" CssClass="renext" OnClick="renext_Click" /><span class="gobakc">跳过，直接进入<a href="<%=UrlHelper.MemberUrl(CurrentUser.uId) %>">个人主页&gt;&gt;</a></span>
                </div>
            </div>
        </div>
        <script>
            jQuery(document).ready(function($) {
                store = $.AMUI.store;
                if (store.get('registurl')) {
                    $(".gobakc").html('跳过，直接返回 <a href="'+store.get('registurl')+'">原页面&gt;&gt;</a>')
                };
            });
            function iFocus(idx, thisa) {
                var thisa = "." + thisa;
                function thisare() {
                    $(thisa).replaceWith("<a class=\"registygz\">已关注</a>")
                }
                $.get("/action/GetFoucsList.ashx", { uId: idx, command: "addFoucs", timestamp: new Date().getTime() }, function (data) {
                    if (data == "1") {
                        $(".toast").html('关注成功').show().addClass('toast-success')
                        errorboxhide()
                    } else {
                        $(".toast").html(data).show().addClass('toast-error')
                        errorboxhide()
                    }
                    setTimeout(thisare, 2000);
                });
            }
            $(".registly").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
        </script>
    </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />