<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanIndex.aspx.cs" Inherits="TrainingPlan_PlanIndex" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>训练计划-跑步装备-益跑网-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <meta property="wb:webmaster" content="a859eadcc5aee52a" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/plan.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script src="/Html/js/jquery-1.11.1.min.js"></script>
    <script src="/Html/js/marathon.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="../Common/jCalendar.js"></script>
</head>
<body>
	<style type="text/css">
		.planbox{display: none;}
    .planbox label{display: block;padding-left: 124px;font-size: 20px;color: #fff;text-shadow: 1.5px 2.598px 5px rgba( 0, 0, 0 ,0.4);cursor: pointer;height: 58px;line-height: 58px;}
    .planbox label input{width: 78px;height: 38px;line-height: 38px;border-radius: 5px;border: 0;padding-left: 8px;font-size: 20px;}
    .planbox label .birthday{background: url(/Html/images/bricon.png)  no-repeat #fff 138px center;width: 160px; }
.planinputbox{position: absolute;width: 278px;height: 240px;z-index: 9999;background: rgba(48,45,23,.95);display: none;border-radius: 3px;box-shadow: 0 3px 0px rgba(0,0,0,.18);font-size: 12px;color: #fff;}
.planinputbox input[type=text]{width: 36px;height: 24px;line-height: 24px;border: 1px solid #282314;border-radius: 1px;color: #43453e;text-align: center;}
.planinputbox i{display: inline-block;width: 78px;text-align: right;font-style: normal;padding-right: 6px}
.planinputbox p{padding-bottom: 18px;}
.planpl{padding: 20px 0 20px 30px}
.planpl input{margin-top: -1px;}
.planbuttommini{width: 61px;height: 26px;line-height: 26px;color: #fff;text-align: center;background: url(/Html/images/planbuttommini.png);display: block;margin: 0px 0 0 84px;}
.planbuttommini:hover{color: #fff;text-decoration: none;cursor: pointer;}
.planwbox{width: 200px;text-align: center;height: 114px;line-height: 25px;padding-top: 30px;}
.planwbox .planbuttommini{margin: 15px auto}
.planinputbox em{width: 0;display: inline-block;height: 0;border-left: 6px solid transparent;border-right: 6px solid transparent;border-bottom: 10px solid rgba(48,45,23,.95);position: absolute;top: -10px;left: 48px;}
.plantbg{width: 100%;height: 100%;position: fixed;display: none;top: 0;left: 0}
	</style>
<form id="form1" runat="server"> 
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="planindex">
    	<div class="articleh">
    		<div class="planindexbanner"><img src="/Html/images/plantop.jpg" ><h1>训练计划</h1></div>
    		<div class="planinr">
 				<div class="planimtitle">什么是训练计划？</div>
 				<p>道格·柯蒂斯(Doug Kurtis)是一名来自密歇根州利沃尼亚的作家和比赛指导。在过去的40年间，他跑了205场马拉松赛，并以3小时内的成绩完成了其中200个。他的第200个3小时内完成的马拉松，就是去年8月的底特律新闻自由马拉松赛；这场比赛让柯蒂斯成为在不同的5个十年内都跑下这项赛事的33个人之一。
通过聪明的训练方式，柯蒂斯成功避免了过度的身体消耗和伤病。大多数时候他都进行慢跑，并选择不同的路线和训练伙伴，每隔一段时间当觉得自己需要休息他就会给自己放几天假。</p>
				<img src="/Html/images/planlz.jpg" />
                <asp:Literal ID="litCreatePlan" runat="server"></asp:Literal>
 				<div class="planimtitle">我的当前训练计划</div>
<%-- 				<div class="thisplan">
 					<h2>周一 . 5公里间歇跑</h2>
					<i>10min LL</i>
					<i>10X400m 休息: 200m</i>
					<i>10min LL</i>
					<i>10min LL</i>
					<i>10X400m 休息: 200m</i>
					<i>10min LL</i>
					<div class="planiaction">
						<em class="plany">已完成</em>
						<em class="planw">未完成</em>
						<em class="planb">补完成</em>
					</div>
					<a href="">查看本周训练计划</a>
 				</div>	--%>
                <asp:Literal ID="litCurrentDayPlaninfo" runat="server"></asp:Literal>
 				<div class="planimtitle">我的历史训练计划</div>
 				<div class="oldiplan">
 					<%--<a href="">第一周：10公里间歇跑</a><a href="">第一周：10公里间歇跑</a><a href="">第一周：10公里间歇跑</a><a href="">第一周：10公里间歇跑</a><a href="">第一周：10公里间歇跑</a>--%>
                     <asp:Literal ID="litHistoryPlans" runat="server"></asp:Literal>
                 </div>
    		</div>
		</div>
    </div>
    <div id="planybox" class="planinputbox"><em></em>
    	<div class="planpl">
            <label><input type="radio" name="fatigue" value="0">不疲劳</label>
			<label><input type="radio" name="fatigue" value="1">轻度疲劳</label>
			<label><input type="radio" name="fatigue" value="2">很疲劳</label>
    	</div>
        <p><label><i>时间:</i><input type="text" name="time" value=""> 分钟</label> </p>
        <p><label><i>平均心率:</i><input type="text" name="avgheartrate" value=""> 次/分钟</label> </p>
        <p><label><i>距离:</i><input type="text" name="km" value=""> 公里</label> </p>
        <a class="planbuttommini">提 交</a>
    </div>
    <div id="planwbox" class="planinputbox planwbox"><em></em>
    	您没有完成今天的计划 <br>
        <a class="planbuttommini">提 交</a>
    </div>
    <input id="ResultState" type="hidden" value="" />
    <input id="currentday" type="hidden" value="<%=currentDay %>" />
    <input id="Plan_PersonId" type="hidden" value="<%=Plan_Person_Id %>" />
    <input id="CurrenWeek" type="hidden" value="<%=currentweek %>"/>
    <input id="currmondayofdate" type="hidden" value="<%=currmondayofdate %>" />
    <div class="plantbg"></div>
</form>
    <script type="text/javascript">
        $(".plany").click(function(event) {
        	$(".plantbg").show()
        	$(".planinputbox").hide()
        	$("#planybox").css({
	        		top: $(this).offset().top+41,
	        		left: $(this).offset().left
        	}).show()
        	if ($(this).text() == "已完成")
        	    $("#ResultState").val("1");
        });
        $(".planw").click(function(event) {
        	$(".plantbg").show()
        	$(".planinputbox").hide()
        	$("#planwbox").css({
	        		top: $(this).offset().top+41,
	        		left: $(this).offset().left
        	}).show()
        	$("#ResultState").val("0");
        });
        $(".plantbg").click(function(event) {
        	$(".planinputbox").hide()
        	$(this).hide()
        });
        $(".planbuttommini").click(function (event) {
            var planpersonid = $("#Plan_PersonId").val();
            var currentweek = $("#CurrenWeek").val();
            var currmondayofdate = $("#currmondayofdate").val();
            var resultstate = $("#ResultState").val();
            var currentday = $("#currentday").val();
            var fatigue = $("input[name='fatigue']:checked").val();
            var time = $("input[name='time']").val();
            var avgheartrate = $("input[name='avgheartrate']").val();
            var km = $("input[name='km']").val();
            var postdata = { planpersonid: planpersonid, currmondayofdate: currmondayofdate, currentweek: currentweek, currentday: currentday, resultstate: resultstate, fatigue: fatigue, time: time, avgheartrate: avgheartrate, km: km ,type:"index"};
            $.post("/TrainingPlan/action/Feedback.ashx", postdata, function (result) {
                var jsonobj = JSON.parse(result);
                if (jsonobj[0] == -4)
                {
                    alert("反馈信息提交未成功，请重新提交！");
                }
                else if (jsonobj[0] == 1)
                {
                    alert("反馈信息提交成功，继续加油！");
                    $("#plancontentofday").html(jsonobj[1]);
                    $("#plancontentofday").append("<div class='planiaction'></div>");
                    $(".plantbg").hide();
                    $(".planinputbox").hide();

                    $("#ResultState").val("");
                    $("#currentday").val("");
                    $("input[name='fatigue']").attr("checked", false);
                    $("input[name='time']").val("");
                    $("input[name='avgheartrate']").val("");
                    $("input[name='km']").val("");
                }
                else if (jsonobj[0] == 0)
                {
                    alert("请先登录！");
                    PopupShowdl(520, 305, '登录', '/utility/include/login.aspx');
                    StatusCheck();
                }
                else if (jsonobj[0] == -1) {
                    alert("本周计划开始时间是" + currmondayofdate+"；请届时再填写训练反馈信息！")
                }
                else if (jsonobj[0] == -3) {
                    alert("你填写的数据不规范，请仔细检查后再提交数据！")
                }
            });
        })
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />

</body>
</html>

