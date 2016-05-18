<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StepFirst.aspx.cs" Inherits="TrainingPlan_StepFirst" %>

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
	</style>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="planbg plancont">
      <form id="planinput" runat="server">
		<div class="planbox" id="p1" style="display:block">
			<div class="planst">跑步目标维度选择问卷</div>
			<h2>跑步基础和目标</h2>
			<ul class="planlist onlist">
				<li data-b="0" data-p="1">0基础，想开始跑步</li>
				<li data-b="1" data-p="1">5公里基础，想跑10公里</li>
				<li data-b="2" data-p="1">10公里基础，想跑半程</li>
				<li data-b="3" data-p="1">半程基础，想跑全程</li>
				<li data-b="4" data-p="1">全程基础，想提高成绩</li>
        <input type="hidden" id="d1" name="d1">
			</ul>
		</div>
		<div class="planbox" id="p2">
			<div class="planst">跑步目标维度选择问卷</div>
			<h2>损伤风险</h2>
			<ul class="planlist onlist">
				<li data-b="101" data-p="2">足膝损伤风险高</li>
				<li data-b="102" data-p="2">足膝损伤风险低</li>
        <input type="hidden" id="d2" name="d2">
			</ul>
			<div class="planbu" onclick="Backoff()">退后一步</div>
		</div>
		<div class="planbox" id="p3">
			<div class="planst">跑步目标维度选择问卷</div>
			<h2>训练周期</h2>
			<ul class="planlist onlist">
				<li data-b="10" data-p="3">10周</li>
				<li data-b="15" data-p="3">15周</li>
        <input type="hidden" id="d3" name="d3">
			</ul>
			<div class="planbu" onclick="Backoff()">退后一步</div>
		</div>
    <div class="planbox" id="p4">
      <div class="planst">跑步目标维度选择问卷</div>
      <h2>输入个人信息</h2>
      <label>生日：<input type="text" name="birthday" class="birthday" onclick="GDate(this);"></label>
      <label>身高：<input type="text" name="height"> 厘米</label>
      <label>体重：<input type="text" name="weight"> 公斤</label>
      <label>晨脉：<input type="text" name="pulse"> 次/分钟</label>
      <div class="planbu" onclick="Goplan()">下一步</div>
    </div>
      </form>
    </div>
     
    <script type="text/javascript">
       var p = 1
       $(".onlist li").click(function(event) {
       		var b = $(this).data('b');
       			p = $(this).data('p')
            $(".planbox").hide()
            $("#p"+(p+1)).show()
            $("#d"+p).val(b)
       });
       function Backoff(){
       		$(".planbox").hide()
   			$("#p"+p).show()
   			p--
       }
       function Goplan(){
           var freqdist = $("#d1").val();
           var level = $("#d2").val();
           var period = $("#d3").val();
           var birthday = $("input[name='birthday']").val();
           var height = $("input[name='height']").val();
           var weight = $("input[name='weight']").val();
           var morningpulse = $("input[name='pulse']").val();
           if (birthday == "") {
               alert("生日不能为空！");
               $("input[name='birthday']").focus();
               return;
           }
           if (height == "") {
               alert("身高不能为空！");
               $("input[name='height']").focus();
               return;
           }
           if (weight == "") {
               alert("体重不能为空！");
               $("input[name='weight']").focus();
               return;
           }
           if (morningpulse == "") {
               alert("晨脉不能为空！");
               $("input[name='pulse']").focus();
               return;
           }

           var postdata = { freqdist: freqdist, level: level, period: period, birthday: birthday, height: height, weight: weight, morningpulse: morningpulse };
           $.post("/TrainingPlan/action/PlanInfo.ashx", postdata, function (returnvalue) {
               switch (returnvalue) {
                   case "-1":
                       alert("请输入完整的个人信息！");
                   case "0":
                       alert("请先登录！");
                       PopupShowdl(520, 305, '登录', '/utility/include/login.aspx');
                       StatusCheck();
                       break;
                   case "1":
                       alert("生成个人训练计划成功！");
                       window.location.href = "/TrainingPlan/PlanIndex.aspx";
                       break;
                   case "2":
                       alert("生成个人训练计划失败！请重试或者联系网站管理员");
                       window.location.href = "/TrainingPlan/PlanIndex.aspx";
                       break;
                   default:
               }
           });

       }
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>

