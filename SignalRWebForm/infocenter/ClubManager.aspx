<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubManager.aspx.cs" Inherits="infocenter_ClubManager" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
</head>
<body>
    <script language="javascript" src="/Common/jQuery1.8.js"></script>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jPopup.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jquery.colorbox.js"></script>
    <script type="text/javascript" src="../Common/jCity.js"></script>
    <style>
    	.newclub{width: 100%;overflow: hidden;margin-top: 70px;font-family: \5FAE\8F6F\96C5\9ED1}
    	.newclub tr td{font-size: 14px;color: #000;}
        .newclub tr td:first-child{width: 260px;text-align: right;}
        .newclub label{margin-bottom: 7px;padding-right: 10px;display: inline-block;}
        .newclub select{width:120px; }
        .newclub textarea{padding: 14px;width: 420px;height: 120px;}
        #idCity,#cCityname{display: none;}
        #b2 { border: 0px; background: none;box-shadow:none;font-size: 12px;margin: -10px 0 0 320px}
        #b2:focus{box-shadow: none;}
        .newclub li{float: left;width: 154px;text-align: center;height: 152px}
        .newclub ul{width: 464px;display: inline-block;padding-top: 20px;}
        .newclub ul label{margin: 0}
    </style>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
       <div class="newclub">
       		<table>
       			<tr>
       				<td><label for="">俱乐部名</label></td>
       				<td>
						<input type="text" value="" tabindex="1" id="name" name="name">
       				</td>
       			</tr>
       			<tr>
       				<td><label for="">城市</label></td>
       				<td>
						<select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)"> </select>
						<select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)"></select>
						<script type="text/javascript">
						BindProvince("北京");
						</script>
						<input name="idCity" type="text" id="idCity" size="5" readonly="" value="0" />
						<input name="cCityname" type="text" id="cCityname" size="15" readonly="" value="北京" />
						<input name="UpdatedFields" type="hidden" id="UpdatedFields" />
       				</td>
       			</tr>
       			<tr>
       				<td><label for="">类型</label></td>
       				<td>
       					<select onchange="selectOneCity(this)" id="ddlCity" name="ddlCity">
       					<option value="秀山">秀山</option>
       					<option value="酉阳">酉阳</option>
       					<option value="黔江">黔江</option>
       					<option value="彭水">彭水</option>
       					</select>
       				</td>
       			</tr>
       			<tr>
       				<td><label for="">俱乐部简介</label></td>
       				<td>
       					<textarea name="" id="Idmsg" ></textarea>
       					<input type="text" id="b2" readonly="readonly" />
       				</td>
       			</tr>
       			<tr>
       				<td><label for="">模板样式</label></td>
       				<td>
       					<ul>
       						<li>
       							<label for="temp1"><img src="/Html/images/v1s.jpg" alt="路跑" /></label>
       							<input value="v1" name="temp" id="temp1" checked="checked" type="radio">
       						</li>
       						<li>
       							<label for="temp2"><img src="/Html/images/v2s.jpg" alt="夕阳" /></label>
       							<input value="v2" name="temp" id="temp2" type="radio">
       						</li>
       						<li>
       							<label for="temp3"><img src="/Html/images/v3s.jpg" alt="跑道" /></label>
       							<input value="v3" name="temp" id="temp3" type="radio">
       						</li>
       						<li>
       							<label for="temp4"><img src="/Html/images/v4s.jpg" alt="减肥" /></label>
       							<input value="v4" name="temp" id="temp4" type="radio">
       						</li>
       						<li>
       							<label for="temp5"><img src="/Html/images/v5s.jpg" alt="户外" /></label>
       							<input value="v5" name="temp" id="temp5" type="radio">
       						</li>
       						<li>
       							<label for="temp6"><img src="/Html/images/v6s.jpg" alt="骑行" /></label>
       							<input value="v6" name="temp" id="temp6" type="radio">
       						</li>
       					</ul>
       				</td>
       			</tr>
       		</table>
       </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script>
    textAreaLimit("Idmsg", { lastMsgLabel: "b2" })
            function textAreaLimit(area, op) {
                var defaultOp = {
                    maxLength: 120 //最大长度 
                , IsNumber: false //只能是数字 
                , lastMsgLabel: null //即时显示可输入个数的Input 
                , msg: "还可以输入{0}个文字"
                , errorMsg: "文字个数超出最大限制"
                };
                var label;
                if (typeof area == "string") {
                    area = document.getElementById(area);
                }
                if (!area) {
                    return;
                }
                for (var i in op) {
                    defaultOp[i] = op[i];
                }
                if (defaultOp.lastMsgLabel) {
                    if (typeof defaultOp.lastMsgLabel == "string") {
                        label = document.getElementById(defaultOp.lastMsgLabel);
                    }
                }
                if (defaultOp.IsNumber) {
                    area.style.imeMode = "Disabled";//IE 
                    area.onkeydown = function () {
                        return event.keyCode != 229;
                    }
                }
                area.onkeyup = function () {
                    if (defaultOp.IsNumber) {
                        this.value = this.value.replace(/\D/g, "");//IE之外的 
                    }
                    if (this.value.length > defaultOp.maxLength) {
                        //------------------------------------------------------------------------------- 
                        //方案① 
                        this.disabled = "disabled";
                        this.value = this.value.slice(0, defaultOp.maxLength);
                        this.removeAttribute("disabled");
                        this.focus();
                        //方案② 
                        //或 
                        //alert(defaultOp.errorMsg); 
                        //this.value = this.value.slice(0,defaultOp.maxLength); 
                        //------------------------------------------------------------------------------- 
                    }
                    if (label) {
                        label.value = defaultOp.msg.replace(/\{0\}/, defaultOp.maxLength - this.value.length);
                    }
                }
            }
    </script>
</body>
</html>