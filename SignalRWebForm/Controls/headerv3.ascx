<%@ Control Language="C#" AutoEventWireup="true" CodeFile="headerv3.ascx.cs" Inherits="Controls_headerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="<%=PBase.page_Description %>">
    <meta name="keywords" content="<%=PBase.page_Keywords %>">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title><%=PBase.page_Title %></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="/assets/i/favicon.png">
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="/assets/css/blueimp-gallery.min.css">
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" href="/Html/css/marathon.css">
    <link rel="stylesheet" type="text/css" href="/Html/css/infocenterv3.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/indexv3.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/infocenterv3media.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/marathonmedia.css" />
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
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/action.js"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    
</head>
<body>
    <div class="header">
        <div class="mine">
            <a href="/" class="logo">
                <img src="/Html/images/logo.png" alt=""></a>
            <div class="nnav">
                <a href="/">首页</a><i>&bull;</i>
                <a href="/Competetion/SearchEvent.aspx">赛事报名</a><i>&bull;</i>
                <a href="/GroupBuy/GroupList.aspx">拼团</a><i>&bull;</i>
                <a href="/channels/cnllist.aspx?id=30002">跑步装备</a><i>&bull;</i>
                <a href="/channels/list.aspx?id=1025">益跑专栏</a>
            </div>
            <div class="nav">
                <a href="/" class="nava">首页</a>
                <div class="nava">
                    赛事
                    <dl>
                        <dt>+ <a href="/Competetion/SearchEvent.aspx">赛事报名</a></dt>
                        <dt>+ <a href="/channels/cnllist.aspx?id=30001">赛事城市</a></dt>
                        <dt>+ <a href="/Channels/Competetion/CompetitionCalendar.aspx">赛事日历</a></dt>
                        <dt>+ <a href="/Channels/Competetion/Album.aspx">赛事相册</a></dt>
                        <dt>+ <a href="/Raceresult/RaceQuery.aspx">成绩查询</a></dt>
                        <dt>+ <a href="/channels/competetion/ApplyFrom.aspx">发布申请</a></dt>
                        <dt>+ <a href="/Flight/flightgroom.aspx">国内机票</a></dt>
                    </dl>
                </div>
                <a class="nava" href="/GroupBuy/GroupList.aspx">拼团</a>
                <div class="nava">
                    装备
                    <dl>
                        <dt>+ <a href="/channels/cnllist.aspx?id=30002">跑步装备</a></dt>
                        <dt>+ <a href="/SmartChooseShoe/ShoeFind.aspx">选鞋</a></dt>
                    </dl>
                </div>
                <div class="nava">
                    训练
                    <dl>
                        <dt>+ <a href="/channels/cnllist.aspx?id=30003">训练提高</a></dt>
                        <dt>+ <a href="/channels/cnllist.aspx?id=30004">营养恢复</a></dt>
                    </dl>
                </div>
                <a class="nava" href="/channels/cnllist.aspx?id=30005">越野跑</a>
                <a class="nava" href="/channels/cnllist.aspx?id=30006">跑者专栏</a>
                <a class="nava" href="/infocenter/ClubSearch.aspx">约跑</a>
                <!-- <a class="nava" href="/infocenter/SearchClub.aspx">俱乐部</a> -->
                <a class="nava" href="/channels/tools/">小工具</a>
                <a class="nava" href="/blog/200959815.aspx">使用帮助</a>
                <!-- <%=NavigatorMenu %>-->
            </div>
            <div class="mh"></div>
            <div class="logincode"></div>
            <div class="both"></div>
        </div>
    </div>
    <div class="mediaLogin"></div>