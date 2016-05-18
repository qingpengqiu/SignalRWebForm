<%@ Control Language="C#" AutoEventWireup="true" CodeFile="tHeader.ascx.cs" Inherits="Controls_tHeader" %>
<div class="header">
	<div class="indecen">
		<div class="topnav" id="user_info">
            <%=login %>
		</div>
		<a href="/" class="logo"><img src="/Images/index/logo.png" alt=""></a>
        <ul class="mnav">
            <li><a href="/channels/competetion/RaceList.aspx">赛事报名</a></li>
            <li><a href="/channels/shoe/">跑步装备</a></li>
            <li><a href="/channels/train/">跑步训练</a></li>
            <li class="navmore"><i>&laquo;</i>
<dl>
    
    <!-- <dd><a href="/infocenter/ClubSearch.aspx">约跑</a></dd>
    <dd><a href="/infocenter/SearchClub.aspx">俱乐部</a></dd> -->
    <dd><a href="/channels/nutrition/">营养瘦身</a></dd>
    <dd><a href="/channels/health/">健康恢复</a></dd>
    <dd><a href="/channels/beginner/">初级跑者</a></dd>
    <dd><a href="/channels/life/">跑步人生</a></dd>
    <dt><a href="/channels/tools/">小工具</a></dt>
</dl>
</li>
        </ul>
		<ul class="nav">
			<li class="h_sy"><a href="/"><em><img src="/Html/images/indexb.png" alt="">首页</em></a> </li>
			<li class="h_js"><em><a href="javascript:void(0)">赛事</a></em>
                <dl>
                    <dt><a href="/channels/competetion/">+ 赛事&bull;城市</a></dt>
                    <dt><a href="/channels/competetion/RaceList.aspx">+ 赛事报名</a></dt>
                    <dt><a href="/Channels/Competetion/Album.aspx">+ 赛事相册</a></dt>
                    <dt><a href="/Raceresult/RaceQuery.aspx">+ 成绩查询</a></dt>
                </dl>
            </li>
            <li class="h_zb"><em><a href="javascript:void(0)">装备</a></em>
                <dl>
                    <dt><a href="/channels/shoe/">+ 跑步装备</a></dt>
                    <dt><a href="/infocenter/ShoeFind.aspx">+ 选鞋</a></dt>
                    <!-- <dt><a href="/channels/competetion/">+ 装备测评</a></dt>
                    
                    <dt><a href="/channels/competetion/">+ 穿衣推荐</a></dt>
                    <dt><a href="/channels/competetion/">+ 团购</a></dt> -->
                </dl>
            </li>
            <li class="h_xl"><em><a href="javascript:void(0)">训练</a></em>
                <dl>
                    <dt><a href="/channels/train/">+ 跑步训练</a></dt>
                    <!-- <dt><a href="/channels/competetion/">+ 训练计划</a></dt>
                    <dt><a href="/channels/competetion/">+ 益跑教练</a></dt> -->
                </dl>
            </li>
            <li class="h_yy"><em><a href="javascript:void(0)">营养恢复</a></em>
                <dl>
                    <dt><a href="/channels/nutrition/">+ 营养瘦身</a></dt>
                    <dt><a href="/channels/health/">+ 健康恢复</a></dt>
                </dl>
            </li>
            <li class="h_zl"><em><a href="javascript:void(0)">跑者专栏</a></em>
                <dl>
                    <!-- <dt><a href="/channels/expert/">+ 益跑专栏</a></dt> -->
                    <dt><a href="/channels/beginner/">+ 初级跑者</a></dt>
                    <dt><a href="/channels/life/">+ 跑步人生</a></dt>
                </dl>
            </li>
            <li class="h_yp"><em><a href="/infocenter/ClubSearch.aspx">约跑</a></em> </li>
            <li class="h_jlb"><em><a href="/infocenter/SearchClub.aspx">俱乐部</a></em> </li>
            <li class="h_gc"><em><a href="/infocenter/Plaza.aspx">跑者广场</a></em> </li>
			<li class="h_gj"><em><a href="/channels/tools/">小工具</a></em> </li>
		</ul>
	</div>
</div>
<script type="text/javascript">
$(".navmore").click(function(event) {
    $(".navmore dl").toggle()
});
    function gettwo() {
        $.ajax({
            type: "GET",
            url: "/infocenter/Include/AjaxCount.aspx",
            data: { rnd: Math.random() },
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                if (msg.hea > "0") {
                    $(".msgshowa").append("<em>" + msg.hea + "</em>")
                }
                if (msg.count > "0") {
                    $(".msgshowl").append("<em>" + msg.count + "</em>")
                }
                if (msg.msgcount > "0") {
                    $(".msgshowb").append("<em>" + msg.msgcount + "</em>")
                    $(".msgshowf").append("<em>" + msg.msgcount + "</em>")
                }
                if (msg.dcscount > "0") {
                    $(".msgshowpl").append("<em>" + msg.dcscount + "</em>")
                }
            }
        });
        setTimeout("gettwo()", 60000)
    }
    $(function () {
        gettwo()
    });
    //头部下拉js
$(".topr").click(function() {
    $(this).children("ul").toggle();
});
$(".topr").hover(function() {
    $(this).children("ul").show()
}, function() {
    $(this).children("ul").hide()
});
$(".nav li em").click(function(event) {
  
    $(this).next("dl").toggle();
});

$(".nav li").hover(function() {
    $(this).children("dl").show()
}, function() {
    $(this).children("dl").hide()
});
</script>
