<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Competetion_Default" %><%@ Register Src="~/Competetion/headerv2.ascx" TagPrefix="ERUN360" TagName="headerv2" %><%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><!DOCTYPE html>
<html lang="cn">
<head>
	<meta charset="UTF-8">
	<title>Marathon</title>
	<link rel="stylesheet" href="/mz/css/amazeui.min.css">
	<link rel="stylesheet" href="/Html/css/marathon.css">
	<script src="/Html/js/jquery-1.11.1.min.js"></script>
	<script src="/Html/js/marathon.js"></script>
	<script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
</head>
<body>
	<ERUN360:headerv2 runat="server" ID="headerv2" />
	<div class="banner">
		<div class="mine">
			<img src="/Html/images/banner.jpg" alt="">
		</div>
	</div>
	<div class="tbody">
		<div class="mine">
			<ERUN360:bmnav runat="server" ID="bmnav" />
			<div class="tbodyBox">
				<div class="present this">
					<div class="Introduction">
						<div class="mthumb">
							<img src="/Html/images/mthumb.jpg" alt="">
						</div>
						<div class="manue" id="information">
							
						</div>
						<div class="both"></div>
						<div class="share">
							<a id="sharewb" href="javascript:void(0)"><img src="http://erun360.com/Html/images/weiboc.png" alt=""> 分享到新浪微博</a> | <a href="javascript:void(0)" id="copyUrl"><img src="http://erun360.com/Html/images/fuzhi.png" alt="" >复制地址</a> | <a href="/infocenter/PostMessage.aspx" class="article-up-iframe"><img src="http://erun360.com/Html/images/friend.png" alt="" >分享给站内好友</a>

						</div>
					</div>
					<div class="czbox">
						<a href="javascript:void(0)" class="gz">立即关注</a><a href="javascript:void(0)" class="bm">立即报名</a>
					</div>
					<div class="manuenr">
					</div>
					<div class="czbox">
						<a href="javascript:void(0)" class="gz">立即关注</a><a href="javascript:void(0)" class="bm">立即报名</a>
					</div>
					<div class="both"></div>
				</div>
				<div class="event">
					<div class="eventTip">
						以下信息为必填项，请认真填写；凡在线报名过的用户我们将自动为您填写部分信息,若您需要修改信息，请直接修改表单内容即可;若您帮朋友报名，请注册新的账号再进行报名
					</div>
					赛事报名
				</div>
				<div class="hotel">
					酒店
				</div>
				<div class="traffic">
					交通
				</div>
				<div class="traveling">
					旅游
				</div>
				<div class="query">
					成绩查询
				</div>
				<div class="visa">
					签证
				</div>
				<div class="equipment">
					推荐装备
				</div>
				<div class="items">
					附加项
				</div>
				<div class="mind">
					赛记
				</div>
				<div class="gameimg">
					比赛图库
				</div>
				<div class="disgroup">
					讨论组
				</div>
			</div>
		</div>
	</div>

    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
	<div class="mxbox">
		<div class="mxzi">
			我的购物车
			<i>3</i>
		</div>
	  <div class="mxlibox">
		<div class="mxli">
			<div class="mxu mxu1">
				<div class="mxui">
					参赛报名费：<i>¥130</i>
				</div>
			</div>
			<div class="mxu">
				<div class="mxut mxui">
					机票<i>¥130</i>
				</div>
				<div class="mxuli mxui">
					北京→广州：<i>¥130</i>
				</div>
				<div class="mxuli mxui">
					北京→广州：<i>¥130</i>
				</div>
				<div class="mxuli mxui">
					北京→广州：<i>¥130</i>
				</div>
			</div>
			<div class="mxu">
				<div class="mxut mxui">
					酒店<i>¥130</i>
				</div>
				<div class="mxuli mxui">
					香格里拉：<i>¥130<em>x2</em></i>
				</div>
				<div class="mxuli mxui">
					台北王朝大酒店：<i>¥130<em>x3</em></i>
				</div>
				<div class="mxuli mxui">
					博鳌大酒店：<i>¥130</i>
				</div>
			</div>
			<div class="mxu">
				<div class="mxut mxui">
					机票<i>¥130</i>
				</div>
				<div class="mxuli mxui">
					北京→广州：<i>¥130</i>
				</div>
				<div class="mxuli mxui">
					北京→广州：<i>¥130</i>
				</div>
				<div class="mxuli mxui">
					北京→广州：<i>¥130</i>
				</div>
			</div>
			<div class="allmx">
				总价：¥5340
			</div>
			<div class="gofk">
				立即付款
			</div>
		</div>
	</div>
       
	</div>
    
</body>
	<script type="text/javascript">
	var action = {
		"result":<%=Result%>,
		"uid":function(){
			return this.result.uid;
		},
		"bm":function(){
			return this.result.bm;
		},
		"gz":function(){
			return this.result.gz;
		},
		"type":['U超级马拉松','M全程马拉松','H半程马拉松','R路跑','C越野跑','T其它'],
		"state":['已报名','未付款','已付款','报名截止','报名未开始','开始报名'],
		"concern":['立即关注','已关注'],
		"tshow":'<div class="manuet">所在城市：{cCityname} <br>竞赛类型：{idCompeteStyle} <br>赛事时间：{dRaceBegin} <br>报名时间(开始)：{dJoinBegin} <br>报名时间(结束)：{dJoinEnd} <br></div><div class="manueb"><div class="openm">展开全部<i></i></div><div ></div><em>报名费用</em> <br>{ssfy}</div><div class="manuetip">益跑网为本团的线上招募平台 <br>本赛事付款成功后获赠 3000~4000积分<br>您可在屏幕上方“我的益跑”-“积分”页面下查看积分记录（<a>积分说明</a>）<br>报名流程可参考：<a href="">教你在益跑网报名赛事（含组队攻略）</a><br>平台报名支付咨询电话：010-84374449（工作日9:30-17:30）<br>工作邮箱：<a href="">zuohz@erun360.com</a></div>',
		"gzzt":['立即关注','已关注'],
		"gzztc":['','gzcg'],
		"bmzt":['待审核','去付款','已报名','已组队','报名未开始','报名截止','立即报名','去组队'],
		"bmztc":['bmdsh','bmqfk','bmybm','bmzd','bmwks','bmjz','','bmqzd'],
		"bmztu":function(){
			return ['/infocenter/Competition.aspx?uId='+this.uid(),'/Channels/Competetion/RacePay.aspx?orderid='+this.result.cOrder_no,'/infocenter/Competition.aspx?uId='+this.uid(),'/Channels/Competetion/Team.aspx?p='+this.result.p,'javascript:void(0)','javascript:void(0)','/Competetion/RaceProject.aspx?idcompete='+this.result.idcompete,'/Channels/Competetion/Team.aspx?p='+this.result.p]
		}
	}
	console.log(action.bmztu()[1])
$("#information").append(nano(action.tshow, action.result))
$(".manuenr").append(nano("{cContent}", action.result))
$(".gz").html(action.gzzt[action.gz()]).addClass(action.gzztc[action.gz()])
$(".bm").html(action.bmzt[action.bm()]).addClass(action.bmztc[action.bm()]).attr('href', action.bmztu()[action.bm()])

$(".gz").click(function(event) {
	$.get('/Competetion/EventInterface.ashx?uid='+action.uid()+'&op=Insert&cid='+action.result.idcompete, function(data) {
		var state = data.status
		if (state == 0) {
			PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
		}else if (state == 1) {
			$(".gz").html('已关注').addClass('gzcg')
		}else if (state == 3) {
			$(".gz").html('立即关注').removeClass('gzcg')
		}
	});
});
function nano(template, data) {
  return template.replace(/\{([\w\.]*)\}/g, function(str, key) {
    var keys = key.split("."), v = data[keys.shift()];
    for (i = 0, l = keys.length; i < l; _i++) v = v[this];
    return (typeof v !== "undefined" && v !== null) ? v : "";
  });
};
	</script>
</html>
 