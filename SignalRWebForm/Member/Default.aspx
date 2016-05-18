<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Member_Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>注册-益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
<meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
<meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/regis.css" rel="stylesheet" type="text/css"/>
<link href="/Common/Calendar.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jPopup.js"></script>
</head>
<body>
<div class="cent">		
		<em>已经是益跑网注册会员 <a href="/Member/Login.aspx"><img src="/images/regis/dl.png" alt=""> </a></em>
		<a href="/" class="logo"></a>
		<div class="zclx">
			用户注册
		</div>
<form id="form1" name="form1" action="Default.aspx" method="post" autocomplete="off">
	<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
	<tr>
		<td align="right">昵称</td>
		<td width="486">
			<input type="text" id="cLoginName" name="cLoginName" maxlength="32"  value="" onblur="if(NullCheck(this)) if(StringCheck(this)) if(LengthCheck(this,2,32)) DuplicateCheck(this);" onclick="$('#check_' + this.id).html('<font>长度为2-32，不得含有空格及非法汉字</font>');"> 
			<span id="check_cLoginName" class="check_echo"></span>
		</td>
	</tr>	
	<tr>
		<td align="right">密码</td>
		<td>
			<input type="password" id="cPassword" name="cPassword" maxlength="32"  value="" onblur="if(NullCheck(this)) if(LengthCheck(this,6,32)) StringCheck(this);" onclick="$('#check_' + this.id).html('<font>长度为6-32,由字母及数字组成</font>');"> 
			<span id="check_cPassword" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right">重复密码</td>
		<td>
			<input type="password" id="cPassword2" name="cPassword2" maxlength="32"  value="" onblur="if(NullCheck(this)) if(LengthCheck(this,6,32)) if(StringCheck(this)) SameCheck(this,'cPassword');" onclick="$('#check_' + this.id).html('<font>同上</font>');"> 
			<span id="check_cPassword2" class="check_echo"></span>
		</td>
	</tr>	
	<tr>
		<td align="right" class="xming" >姓名</td>
		<td class="xming" >
			<input type="text" id="cName" name="cName" maxlength="255"  value="" onblur="if(NullCheck(this)) if(LengthCheck(this,2,16)) StringCheck(this);" onclick="$('#check_' + this.id).html('<font>您的真实姓名</font>');"> 
			<span id="check_cName" class="check_echo"></span>
		</td>
	</tr>		
	<tr>
		<td align="right" valign="top" class="xbie" >性别</td>
		<td class="xbie" >
<% =GCommon.Controls("性别","radio", "idGender", "0") %>
		</td>
	</tr>
	<tr>
		<td align="right">生日</td>
		<td>
			<input type="text" id="dBirthday" name="dBirthday" maxlength="255"  readonly value="选择生日" onclick="GDate(this);" style="cursor:pointer;"> 
		</td>
	</tr>
	<tr>
		<td align="right" class="mmwttd">密保问题</td>
		<td class="mmwttd">
			<div class="mmwt">
			<select onchange="UpdateHistory(this)" name="idQuestion" id="idQuestion" value="选择生日" >
				<option value="0">我手机号码的后6位</option>
				<option value="1">我母亲的生日</option>
				<option value="2">我父亲的生日</option>
				<option selected="" value="3">我的跑步格言</option>
				<option value="4">我第一次马拉松成绩</option>
				<option value="5">我第一次参加马拉松的时间</option>
				<option value="6">我第一次参加马拉松的名称</option>
				<option value="7">我最喜爱的跑鞋型号</option>
				<option value="8">我最喜爱的跑步歌曲</option>
				<option value="9">我最喜爱的跑步地点</option>
				<option value="10">我最喜欢的小说</option>
			</select>
			</div>
			答案
			<input type="text" id="cAnswer" name="cAnswer" size="16" maxlength="255"  value="" onblur="if(NullCheck(this)) if(LengthCheck(this,4,32)) StringCheck(this);" onclick="$('#check_' + this.id).html('<font>必填</font>');"> 
			<span id="check_cAnswer" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right"></td>
		<td class="xyi">
			<input checked="checked" type="checkbox" id="inputCheck" name="after" />我已经看过并同意<a href="/channels/about/lawyer.aspx" target="_blank">《益跑网服务使用协议》</a>
		</td>
	</tr>
	<tr>
		<td></td>
		<td>
			<div id="submit_command" >
				<img src="/images/regis/zch.png" onmouseover="ShowSubmit();">
			</div>
			<div id="total_echo" >
				<% =PageResult %>
			</div>
		</td>
	</tr>
	</table>
	</form>
	<div class="footer_w">
    <a title="" href="http://www.erun360.com/">益跑首页</a> -  <a title="" href="http://www.erun360.com/channels/about/">关于益跑</a> -  <a title="" href="http://www.erun360.com/channels/about/contact.aspx">联系我们</a> -  <a title="" href="http://www.erun360.com/channels/about/job.aspx">加入益跑</a> -  <a title="" href="http://www.erun360.com/member/">会员中心</a><br>
    益跑网 京ICP备12042185号 Copyright &copy;2012北京益跑信息技术有限公司 版权所有
    </div>
	</div>
<script language="javascript">
var dupChecked = false;
function DuplicateCheck(obj)
{
    $.post("/Utility/Ajax/MemberDuplicate.aspx", { cloginname: obj.value }, function(result) {
        if (result == "OK") {
            dupChecked = false;
            $("#check_" + obj.id).html(imgErr + "无法使用该登录名！");
            return false;
        }
        else {
            dupChecked = true;
            $("#check_" + obj.id).html(imgOk);
            CheckClear();
            return true;
        }
    });
}
function verifyAll()
{
	var check_num = 5;
	var obj = $("#cLoginName")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) if(LengthCheck(obj,2,32)) if(dupChecked) { check_num--; }
	obj = $("#cPassword")[0];
	if(NullCheck(obj)) if(LengthCheck(obj,6,32)) if(StringCheck(obj)) { check_num--; }
	obj = $("#cPassword2")[0];
	if(NullCheck(obj)) if(LengthCheck(obj,6,32)) if(StringCheck(obj)) if(SameCheck(obj,'cPassword')) { check_num--; }
	obj = $("#cName")[0];
	if(NullCheck(obj)) if(LengthCheck(obj,2,16)) if(StringCheck(obj)) { check_num--; }
	obj = $("#cAnswer")[0];
	if(NullCheck(obj)) if(LengthCheck(obj,4,32)) if(StringCheck(obj)) { check_num--; }
	if($("#dBirthday")[0].value.length < 8) {
		$("#total_echo").html("必须输入生日哦！");
		return false;
	}
    return (check_num == 0) ? true : false;
}
function ShowSubmit()
{
	if(verifyAll())
	{
		$("#submit_command").html("<img src='/images/regis/zc.png' onclick='Finish()'>");
	}
}
function Finish()
{
    if(verifyAll())
    {
       document.form1.submit();
       return true;
    }
	else
	{
		$("#total_echo").html("不行啊！提交数据还有错误哦！");
	}
    return false;
}
</script>
<script src="http://s14.cnzz.com/stat.php?id=4723271&web_id=4723271&show=pic" language="JavaScript"></script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("a[title='站长统计']").hide();
        });
    </script>
</body>
</html>
