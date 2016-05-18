<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register3.aspx.cs" Inherits="Member_Register3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>填写跑界名片</title>
    <meta name="keywords" content="">
    <meta name="description" content="填写跑界名片——记录自己的跑步信息，并且能让大家更多的了解你，并随时可以在账户管理里持续更新；可以获得50积分！" />
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
            <div class="refrome recard">
                <h3>填写跑界名片——记录自己的跑步信息，并且能让大家更多的了解你，并随时可以在账户管理里持续更新；<span>可以获得50积分！</span><a target="_blank" href="/blog/200016255.aspx">积分用途?</a></h3>
                <div class="the-title">
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="run-year">哪年开始跑步</label></div>
                        <div class="refrometd">
                            <input id="runyear" name="runyear" class="registmi" runat="server" type="text" readonly onclick="WdatePicker({ dateFmt: 'yyyy' })" value="2010" /> <label for="marathon-num">年</label>
                        </div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="marathon-num">参加过多少场马拉松</label></div>
                        <div class="refrometd">
                            <input type="text" name="marathonnum" id="marathonnum" value="0" runat="server" class="registmi"/> <label for="marathon-num">场</label>
                        </div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="country-num">参加过多少场越野跑</label></div>
                        <div class="refrometd">
                            <input class="registmi" type="text" name="countrynum" id="countrynum" value="0" runat="server" /> <label for="country-num">场</label>
                        </div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="marathon-best">马拉松最好成绩</label></div>
                        <div class="bestmls refrometd">
                            <select id="marathonbest" runat="server">
                                <option value="1">全程马拉松</option>
                                <option value="2">半程马拉松</option>
                            </select> <label for="results">成绩</label><input onfocus="_SetTime(this)" type="text" class="registmi" name="results" id="results" value="" runat="server" /><div class="contstime">
                            <script type="text/javascript" src="../Html/js/contents.js"></script>
                            </div>
                            </div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="one-game">个人最满意的一场比赛</label></div>
                        <div class="refrometd">
                            <input type="text" name="name" id="onegame"  value="" runat="server" /></div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="record">赛事记录</label></div>
                        <div id="runidcard" runat="server" class="refrometd">
                            <div id="add-records">
                                <div class="recoretr">
                                    <div class="recoretd">年份</div>
                                    <div class="recoretd">赛事名称</div>
                                    <div class="recoretd">成绩</div>
                                </div>
                                <div class="recoretr">
                                    <div class="recoretd">
                                        <input type="text" value="2015" id="iYear1" name="iYear1" onclick="WdatePicker({ dateFmt: 'yyyy' })">
                                    </div>
                                    <div class="recoretd">
                                        <input type="text" value="" id="cName1" name="cName1">
                                    </div>
                                    <div class="recoretd">
                                        <input type="text" value="00:00:00" id="dTime1" name="dTime1" >
                                    </div>
                                </div>
                            </div>
                            <a href="javascript:void(0)" class="add-records">+添加记录</a>
                        </div>
                    </div>
                </div>
                <div class="bottom">
                    <div class="renext">下一步</div><asp:Button ID="renextm" runat="server" Text="下一步"  OnClick="renext_Click" /><span>跳过，直接进入<a href="<%=UrlHelper.MemberUrl(CurrentUser.uId) %>">个人主页&gt;&gt;</a></span>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="iRecord" runat="server" Value="<%=num%>"/>
        <script>
        jQuery(document).ready(function($) {
            store = $.AMUI.store;
            if (store.get('registurl')) {
                $(".gobakc").html('跳过，直接返回 <a href="'+store.get('registurl')+'">原页面&gt;&gt;</a>')
            };
        });
        $(".renext").click(function(event) {
            var go = 1
            $(".recard input").each(function(index, el) {
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



            var num = 2;
            $(".add-records").click(function () {
                $("#add-records").append('<div class="recoretr"><div class="recoretd"><input type="text" value="2015" id="iYear'+ num +'" name="iYear'+ num +'" onclick="WdatePicker({ dateFmt: "yyyy" })"></div><div class="recoretd"><input type="text" value="" id="cName'+ num +'" name="cName'+ num +'"></div><div class="recoretd"><input type="text" value="00:00:00" id="dTime'+ num +'" name="dTime'+ num +'" ></div></div>')
                $("#iRecord").attr("value", num);
                num++;
            });
        </script>
    </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />