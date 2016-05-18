<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MarathonPace.aspx.cs" Inherits="_Channels_Tools_MarathonPace" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>����������ָ��</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />

<meta name="keywords" content="2013���Ź���������,����,���Ӿ���,����ָ��,�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<link href="/Common/tools.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
<script language="javascript" src="/Common/jQuery.js?2012111"></script>
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>	
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
<!--�ڶ���-->
<div id="H2_w" >
	<div id="cal_main">
		<div id="guide">
			<ul>
				<li><a href="PaceCalculator.aspx">���ټ�����<i>��Pace Calculator��</i></a></li>
				<li><a href="PaceConverter.aspx">����ת������Pace Converter��</a></li>
				<li><a href="FinishTime.aspx">���ܼ�������Finish Time��</a></li>
				<li class="dq"><a href="MarathonPace.aspx">����������ָ��<em>��Marathon Pace��</em></a></li>
				<li><a href="AgeGrade.aspx">����ȼ���������Age-graded��</a></li>
				<li><a href="BMI.aspx">BMI����ָ��������</a></li>
				<li><a href="Calorie.aspx">��·�������<i>��Calorie��</i></a></li>
				<li><a href="Training.aspx">ѵ��������</a></li>
				<li><a href="Grade.aspx">�����˶�Ա�ȼ�</a></li>
				<li><a href="BMR.aspx">������л������</a></li>
				<li><a href="ShoeSize.aspx">Ь����ձ�</a></li>
				<li><a href="Converter.aspx">��Ӣ��ת��</a>	</li>
			</ul>				
			<script language="javascript" src="/common/jtools.js"></script>
		</div>
		<div id="cont">
			<span>����������ָ��<em>��Marathon Pace Guide��</em></span>
			<p>
				������������ Ԥ��������ʱ�䣨��Сʱ?�֣��룩��Ԥ�����٣����֣���/��������������һ���ÿ�������õ�ʱ�䣨1-42���
			</p>
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="100">
			<tr>
				<td nowrap align="right">
					Ԥ��������ʱ�䣺
				</td>
				<td nowrap>
					<% =GCommon.HMS("hours", 2, 12, 2) %> ʱ
					<% =GCommon.HMS("minutes", 0, 59, 0) %> ��
					<% =GCommon.HMS("seconds", 0, 59, 0) %> ��
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					�� Ԥ�����٣�
				</td>
				<td nowrap>
					<input type="text" class="ik" id="minutes2" name="minutes2" size="3" maxlength="2" value=""> ��
					<input type="text" class="ik" id="seconds2" name="seconds2" size="3" maxlength="2" value=""> �� / ����
				</td>
			</tr>
			</table>
			<div class="tj">
					<a id="btn2" class="calcu" onclick="OK()">���� </a>
					<a id="btn" class="calcure" onclick="Clear()">����</a>
					<a id="calorie"></a>				
			</div>
			<div id="jieguo">
				ÿ�������õ�ʱ�䣺
			</div>		
			<a class="appdownv" href="/down/indexwap.html"><img src="/Html/images/appdownv.jpg"></a>	
			</form>
		</div>
	</div>
</div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
<script language="javascript">

function Clear()
{
	document.getElementById("hours").value = "";
	document.getElementById("minutes").value = "";
	document.getElementById("seconds").value = "";
	document.getElementById("minutes2").value = "";
	document.getElementById("seconds2").value = "";
	document.getElementById("calorie").innerHTML = "";
}

function OK()
{
	var hours = document.getElementById("hours").value;
	var minutes = document.getElementById("minutes").value;
	var seconds = document.getElementById("seconds").value;
	var minutes2 = document.getElementById("minutes2").value;
	var seconds2 = document.getElementById("seconds2").value;
	
	document.getElementById("calorie").innerHTML = "";

	if(hours.length > 0 && minutes.length > 0 && seconds.length > 0)
	{
		var speed = parseInt(hours) * 3600 + parseInt(minutes) * 60 + parseInt(seconds);
		//alert(speed);
		$.get("/channels/tools/ajax/marathonpace.aspx", { seconds : speed, mode : 0 }, function(result) {
			document.getElementById("jieguo").innerHTML = result;
		});
		return;
	}

	if(minutes2.length > 0 && seconds2.length > 0)
	{
		var speed = parseInt(minutes2) * 60 + parseInt(seconds2);
		$.get("/channels/tools/ajax/marathonpace.aspx", { seconds : speed, mode : 1 }, function(result) {
			document.getElementById("jieguo").innerHTML = result;
		});
		return;
	}

	document.getElementById("calorie").innerHTML = "�������ݲ���";
}

</script>
</body>
</html>
