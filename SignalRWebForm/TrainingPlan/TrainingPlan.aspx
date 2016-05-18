<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TrainingPlan.aspx.cs" Inherits="TrainingPlan_TrainingPlan" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
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
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Html/css/plan.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<style type="text/css">
body{position: relative;}
.plan{background-image: url(/Html/images/planbgn.jpg);padding:48px 0;}
.plannew{width: 930px;border: 1px solid rgba(255,255,255,.6);margin: 0px auto;background: rgba(55,54,40,.8);font-size: 12px;line-height: 24px;color: #fff;text-align: center;}
.plantr{overflow: hidden;display: table-row;}
.plantd{display: table-cell;background: rgba(245,243,243,.15);border-right: 1px solid rgba(255,255,255,.3);border-bottom: 1px solid rgba(255,255,255,.3);padding: 28px 15px;min-height:72px;vertical-align: middle;}
.plantr:first-child .plantd{height: 37px;line-height: 37px;background: none;font-size: 14px;color: #fff;padding: 0}
.plantr:last-child .plantd{border-bottom: 0}
.plantr .plantd:first-child{width: 92px;background: none;padding: 0}
.plantr .plantd:last-child{border-right: 0;width: 450px;}
.plantr .plantd:nth-child(2){width: 386px;}
.planbuttom{display: inline-block;width: 108px;height: 31px;background: url(/Html/images/planbuttom.png) center top;line-height: 31px;margin: 0 6px}
.planbuttom:hover{background-position: center bottom;cursor: pointer;}
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
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server"> 
    <div class="plan ">
        <input type="hidden" id="Plan_PersonId"  value="<%=Plan_Person_Id %>" />
        <input type="hidden" id="CurrenWeek" value="<%=currentweek %>" />
        <input type="hidden" id="currmondayofdate" value="<%=currmondayofdate %>" />
        <div class="plannew">
        	<div class="plantr">
        		<div class="plantd">第<%=strcurrentweek %>周</div>
        		<div class="plantd">训练内容</div>
        		<div class="plantd">训练后反馈</div>
        	</div>
            <asp:Literal ID="litWeekPlan" runat="server"></asp:Literal>
<%--        	<div class="plantr">
        		<div class="plantd">周一</div>
        		<div class="plantd">
        			10min LL <br>
					10X400m 休息: 200m <br>
					10min LL</div>
        		<div class="plantd"><input type="hidden" class="weekday" value="1" /><div class="planbuttom plany">已完成</div><div class="planbuttom planw">未完成</div><div class="planbuttom planb">补完成</div></div>
        	</div>
        	<div class="plantr">
        		<div class="plantd">周二</div>
        		<div class="plantd">
        休息
        			</div>
        		<div class="plantd"></div>
        	</div>
        	<div class="plantr">
        		<div class="plantd">周三</div>
        		<div class="plantd">
        慢跑2分钟健步走2分钟，慢跑2分钟健步走1分钟，慢跑2分钟健步走1分钟，慢跑2分钟健步走1分钟，慢跑2分钟健步走1分钟，慢跑2分钟健步走1分钟，慢跑2分钟健步走1分钟，慢跑2分钟健步走1分钟，共25分钟 GR
        		</div>
        		<div class="plantd"><input type="hidden" class="weekday" value="3" /><div class="planbuttom plany">已完成</div><div class="planbuttom planw">未完成</div><div class="planbuttom planb">补完成</div></div>
        	</div>
        	<div class="plantr">
        		<div class="plantd">周四</div>
        		<div class="plantd">
        			10min LL <br>
					10X400m 休息: 200m <br>
					10min LL</div>
        		<div class="plantd">已完成 | 状态：不疲劳 | 时间：90 分钟 | 平均心率：120 次/分钟 | 距离：12 公里</div>
        	</div>
            <div class="plantr">
                <div class="plantd">周四</div>
                <div class="plantd">
                    10min LL <br>
                    10X400m 休息: 200m <br>
                    10min LL</div>
                <div class="plantd">已完成 | 状态：不疲劳 | 时间：90 分钟 | 平均心率：120 次/分钟 | 距离：12 公里</div>
            </div>
            <div class="plantr">
                <div class="plantd">周四</div>
                <div class="plantd">
                    10min LL <br>
                    10X400m 休息: 200m <br>
                    10min LL</div>
                <div class="plantd">已完成 | 状态：不疲劳 | 时间：90 分钟 | 平均心率：120 次/分钟 | 距离：12 公里</div>
            </div>
            <div class="plantr">
                <div class="plantd">周四</div>
                <div class="plantd">
                    10min LL <br>
                    10X400m 休息: 200m <br>
                    10min LL</div>
                <div class="plantd">已完成 | 状态：不疲劳 | 时间：90 分钟 | 平均心率：120 次/分钟 | 距离：12 公里</div>
            </div>--%>
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
    <input id="currentday" type="hidden" value="" />
    <div class="plantbg"></div>
    <script type="text/javascript">
        $(".plany,.planb").click(function(event) {
        	$(".plantbg").show()
        	$(".planinputbox").hide()
        	$("#planybox").css({
	        		top: $(this).offset().top+41,
	        		left: $(this).offset().left
        	}).show()
        	if ($(this).text() == "已完成")
        	    $("#ResultState").val("1");
        	else if ($(this).text() == "补完成")
        	    $("#ResultState").val("2");
        	$("#currentday").val($(this).parent().find(".weekday").val());
        });
        $(".planw").click(function(event) {
        	$(".plantbg").show()
        	$(".planinputbox").hide()
        	$("#planwbox").css({
	        		top: $(this).offset().top+41,
	        		left: $(this).offset().left
        	}).show()
        	$("#ResultState").val("0");
        	$("#currentday").val($(this).parent().find(".weekday").val());
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
            var postdata = { planpersonid: planpersonid, currmondayofdate: currmondayofdate, currentweek: currentweek, currentday: currentday, resultstate: resultstate, fatigue: fatigue, time: time, avgheartrate: avgheartrate, km: km };
            $.post("/TrainingPlan/action/Feedback.ashx", postdata, function (result) {
                var jsonobj = JSON.parse(result);
                if (jsonobj[0] == -4)
                {
                    alert("反馈信息提交未成功，请重新提交！");
                }
                else if (jsonobj[0] == 1)
                {
                    alert("反馈信息提交成功，继续加油！");
                    $(".plantr:eq(" + currentday + ")").find(".plantd:eq(2)").text(jsonobj[1]);
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
                else if (jsonobj[0] == -2) {
                    alert("这一天的训练计划还未开始；请" + jsonobj[1] + "再填写训练反馈信息！")
                }
                else if (jsonobj[0] == -3) {
                    alert("你填写的数据不规范，请仔细检查后再提交数据！")
                }
                else if (jsonobj[0] == 2) {
                    alert("上周补填完成，但是连续两次是疲劳状态，系统为您生成了更适合的训练计划，继续加油！");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
                else if (jsonobj[0] == 3) {
                    alert("上周补填完成，本周连续两次是疲劳状态，下周将执行上一周的训练计划内容，继续加油！");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
                else if (jsonobj[0] == 4) {
                    alert("上周补填完成，但是连续两周都没有完成训练计划，训练计划将重新开始，继续加油！");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
                else if (jsonobj[0] == 9) {
                    alert("上周补填完成，恭喜您完成了个人训练计划！");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
                else if (jsonobj[0] == 10) {
                    alert("上周训练计划已全部完成，继续加油！");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
            });
        })
    </script>
    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>