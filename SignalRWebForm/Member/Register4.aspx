<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register4.aspx.cs" Inherits="Member_Register4" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>填写身体数据</title>
    <meta name="keywords" content="">
    <meta name="description" content="填写身体数据——记录您的身体数据，以便于我们更好的为您推荐所需的装备；可以获得50积分！" />
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
            <div class="refrome repepple">
                <h3>填写身体数据——记录您的身体数据，以便于我们更好的为您推荐所需的装备；<br><span>可以获得50积分！</span><a target="_blank" href="/blog/200016255.aspx">积分用途?</a></h3>
                <div class="repshow">
                   <ul class="py-data">
                            <li>
                                <label for="height">身高：</label><input type="text" name="height" id="height" value=""  runat="server"/><label for="height">（厘米）</label></li>
                            <li>
                                <label for="weight">体重：</label><input type="text" name="weight" id="weight" value="" runat="server"/><label for="weight">（公斤）</label></li>
                            <li>
                                <label for="chest">胸围：</label><input type="text" name="chest" id="chest" value="" runat="server"/><label for="chest">（厘米）</label></li>
                            <li>
                                <label for="waistline">腰围：</label><input type="text" name="waistline" id="waistline" value="" runat="server"/><label for="waistline">（厘米）</label></li>
                            <li>
                                <label for="hips">臀围：</label><input type="text" name="hips" id="hips" value="" runat="server"/><label for="hips">（厘米）</label></li>
                            <li>
                                <label for="feet-wide">脚宽：</label><input type="text" name="feetwide" id="feetwide" value="" runat="server"/><label for="feet-wide">（厘米）</label></li>
                            <li>
                                <label for="feet-long">脚长：</label><input type="text" name="feetlong" id="feetlong" value="" runat="server" /><label for="feet-long">（厘米）</label></li>
                        </ul>
                </div>
                <div class="bottom">
                    <div class="renext">下一步</div><asp:Button ID="renextm" runat="server" Text="下一步" OnClick="renext_Click" /><span>跳过，直接进入<a href="<%=UrlHelper.MemberUrl(CurrentUser.uId) %>">个人主页&gt;&gt;</a></span>
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
        $(".renext").click(function(event) {
            var go = 1
            $(".repepple input").each(function(index, el) {
                if (!$(this).val()) {
                        $(".toast").html('所有都填写完成才可以提交哦！').show().addClass('toast-error')
                        $(this).addClass('errorinput').focus();
                        errorboxhide()
                        go = 0
                        return false
                }else{
                    $(this).removeClass('errorinput')
                    go = 1
                }
            });
        
            if(go == 1){
                $("#renextm").click();
            }
        });
        </script>
    </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />