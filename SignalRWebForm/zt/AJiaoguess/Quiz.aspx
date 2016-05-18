<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Quiz.aspx.cs" Inherits="zt_AJiaoguess_Quiz" %>
<%@ Register Src="~/Competetion/headerv2.ascx" TagPrefix="ERUN360" TagName="headerv2" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>雪娇大北备战记竞猜成绩赢积分</title>
		<meta name="keywords" content="雪娇大北备战记竞猜成绩赢积分" />
		<meta name="description" content="雪娇大北备战记竞猜成绩赢积分" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="/Html/css/marathon.css">
		<link rel="stylesheet" type="text/css" href="css/db.css"/>
		<script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
	</head>
	<body>
    <ERUN360:headerv2 runat="server" ID="headerv2" />
		<div class="indecen">
			<div class="hd">
				<img src="img/logo.png"/>
			</div>
			<div class="show">
				<img src="img/z.png"/>
				<div class="showbox">
					<h1>大北半程马拉松</h1>
					大北赛(Great North Run)——被誉为世界上第二大半程马拉松比赛，同时也是全英最大规模的城市马拉松赛事，顶着“世界上第二大半程马拉松”的头衔，“大北赛”最近一次(2014年)的参赛人数已经超过 57000人，要比伦敦马多出差不多10000 人。每年9月都会在英国纽卡斯尔和南希尔兹两地间如火如荼地举行，“大北赛”的发起人是曾经三次参加奥运会并获蒙特利尔奥运会男子 10000 米跑铜牌的福斯特布兰登，正是这位长跑名将开启了英伦奔跑风气的先河。起初的“大北跑”其实就更像是一个英国当地跑者的“欢乐跑”，其比赛路线是由地处英伦北部的纽卡斯尔泰恩河畔跑到不远的南希尔兹市，“大北赛”也由此而得名。一年一度的“大北赛”已经举办了34届，这项赛事总是能吸引着全英国人民的目光和热情参与，其参与度和影响力在腐国堪称一绝。
				</div>
			</div>
			<div class="timebox <%=str %> over"> <!-- timeout -->
				<div class="cai <%=jf11 %>">
					<div class="q">
						<i>完赛时间</i>
						<em>2:20-2:35</em>
						<i>竞猜积分</i>
						100
						<i>获得积分</i>
						<em>220</em>
					</div>
					<a href="javascript:void(0)" class="c" data-cid="1" data-t="2:20-2:35">
						点击竞猜
					</a>
                    <div class="tc">
						  您参与的竞猜积分为:
						<i><%=jf1 %></i>
					</div>
				</div>
				<div class="cai <%=jf22 %>">
					<div class="q">
						<i>完赛时间</i>
						<em>2:36-2:50</em>
						<i>竞猜积分</i>
						100
						<i>获得积分</i>
						<em>180</em>
					</div>
					<a href="javascript:void(0)" class="c" data-cid="2" data-t="2:36-2:50">
						点击竞猜
					</a>
					<div class="tc">
						  您参与的竞猜积分为:
						<i><%=jf2 %></i>
					</div>
				</div>
				<div class="cai <%=jf33 %>">
					<div class="q">
						<i>完赛时间</i>
						<em>2:51-3:05</em>
						<i>竞猜积分</i>
						100
						<i>获得积分</i>
						<em>200</em>
					</div>
					<a href="javascript:void(0)" class="c" data-cid="3" data-t="2:51-3:05">
						点击竞猜
					</a>
                    <div class="tc">
						  您参与的竞猜积分为:
						<i><%=jf3 %></i>
					</div>
				</div>
				<div class="cai <%=jf44 %>">
					<div class="q">
						<i>未完成比赛</i>
						<em>退赛</em>
						<i>竞猜积分</i>
						100
						<i>获得积分</i>
						<em>220</em>
					</div>
					<a href="javascript:void(0)" class="c" data-cid="4" data-t="未完成比赛">
						点击竞猜
					</a>
                    <div class="tc">
						  您参与的竞猜积分为:
						<i><%=jf4 %></i>
					</div>
				</div>
				<div class="resultbox">
					完赛成绩 : 03:03:51
				</div>
			</div>
			<div class="time">
				<i>开始时间：</i>2015年8月31日/<i>结束时间：</i>2015年9月13日
			</div>
			<div class="g">
				<h3>游戏规则</h3>
				1.凡是益跑网注册用户，均可参与竞猜游戏。 <br />
				2.竞猜项目：雪蛟《英国大北半程马拉松》完赛成绩。<br />
				3.当竞猜项目出现取消、中断、腰斩、提前或推迟等不可抗力因素时，<br />
				竞猜也将取消，用户所竞猜的积分将全部返还。<br />
				4.竞猜结束后，将在7个工作日内结算竞猜积分。<br />
				5.停止受注时间为2015年9月13日截止。<br />
				6.一旦完成了竞猜操作，不能再进行修改与取消，所以操作请慎重。<br />
				7.网友务必保护好自己的帐号及密码，如出现帐号或密码被盗用，责任全部由网友自己承担。<br />
				8.益跑网有权利随时更改游戏规则。本规则由益跑网制定，<br />
				解释权、修改权归益跑网所有，益跑网有权修改游戏规则而无须事先通知。
				<a href="/blog/200016255.aspx" target="_blank">益跑网积分规则<i>>></i></a>
				<a href="/blog/200221120.aspx">跑者介绍<i>>></i></a>
			</div>
		</div>
		<div class="jbg"></div>
		<div class="jbox">
			<div class="x">x</div>
			您现有积分：<%=isout %>分 <br>
			请您输入参与竞猜的积分
			<div class="ci">
				<i data-d="0">-</i>
				<input type="text" value="100" name="cb" id="ub">
				<i data-d="1">+</i>
			</div>
			<span>本竞猜100积分起，整百递进，5000积分封顶</span>
			<a href="javascript:void(0)" class="cb">确认</a>
		</div>
		<script type="text/javascript">
			var big = parseInt(<%=isout %>/100)*100,
				d = <%=uId%>,
				dt = '',
				t = ''

			$(".c").click(function(event) {
				dt = $(this).data('cid')
				t = $(this).data('t')
				if (d == 0) {
					PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
					return false
				}
				$(".jbg").show()
				$(".jbox").show()
			});
			$(".x,.jbg").click(function(event) {
				$(".jbg").hide()
				$(".jbox").hide()
			});
			$(".ci i").click(function(event) {
				var d = $(this).data('d'),
					v = $("#ub").val()
				if (d == 0) {
					if (v <= 100) {
						alert("最小竞猜为100")
						$("#ub").val(100)
						return false
					};
					$("#ub").val(eval(v-100))
				}else{
					if (v >= big) {
						alert("您最多使用"+big+"积分竞猜")
						$("#ub").val(big)
						return false
					};
					$("#ub").val(eval(v-0+100))
				}
				
			});
			$(".cb").click(function(event) {
				var ub = $("#ub").val(),
					v = $("#ub").val()
				if(ub < 100){
					alert("最少使用100积分参与竞猜")
					$("#ub").val(100)
					return false
				}else if(ub>big){
					alert("您最多使用"+big+"积分竞猜")
					$("#ub").val(big)
					return false
				}else if(ub%100 != 0) {
					alert("竞猜金币必须为100的倍数")
					$("#ub").val(parseInt(v/100)*100)
					return false
				}else{
					$.ajax({
					    url: '/action/Quiz.ashx?op=ajiao',
						type: 'get',
						dataType: 'json',
						data: {uid: d,idMin: dt,iAmount:$("#ub").val(),cMinName: t},
						success:function(d){
							if (d.status == 1) {
								alert("提交成功，请等待竞猜结果	")
							}else if(d.status == -1){
							    PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
							}else {
							    alert(d.msg)
							}
							location.reload()
							// setTimeout(function(){
							// 	location.reload()
							// }, 3000)
						}
					})
					
				}
			});
		</script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
	</body>
</html>

