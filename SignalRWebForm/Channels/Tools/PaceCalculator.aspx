<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaceCalculator.aspx.cs" Inherits="_Channels_Tools_PaceCalculator" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>���ټ�����</title>
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
</head>
<body>
<script language="javascript" src="/Common/jQuery.js?2012111"></script>
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>	
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
<!--�ڶ���-->
<div id="H2_w">
	<div id="cal_main">
		<div id="guide">		
			<ul>
				<li class="dq"><a href="PaceCalculator.aspx">���ټ�����<i>��Pace Calculator��</i></a></li>
				<li><a href="PaceConverter.aspx">����ת������Pace Converter��</a></li>
				<li><a href="FinishTime.aspx">���ܼ�������Finish Time��</a></li>
				<li><a href="MarathonPace.aspx">����������ָ��<i>��Marathon Pace��</i></a></li>
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
			<span>���ټ�����<em>��Pace Calculator��</em></span>
			<p>
���������˶���ѵ���г�ʹ�õ�һ������������ٶȵ�һ�֣���ÿ��������Ҫ��ʱ�䡣����=ʱ��/���롣�ڱ�ҳ���������١�ʱ�䡢���������е������������������
			</p>
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="100">
			<tr>
				<td nowrap>
					���룺
				</td>
				<td nowrap>
					<input type="text" class="ik" id="distance" name="distance" size="3" value=""> ����
				</td>
			</tr>
			<tr>
				<td nowrap>
					ʱ�䣺
				</td>
				<td nowrap>
					<input type="text" class="ik" id="hours" name="hours" size="3" value="0"> ʱ
					<input type="text" class="ik" id="minutes" name="minutes" size="3" value=""> ��
					<input type="text" class="ik" id="seconds" name="seconds" size="3" value=""> ��
				</td>
			</tr>
			<tr>
				<td nowrap>
					���٣�
				</td>
				<td nowrap>
					<input type="text" class="ik" id="speed_minutes" name="speed_minutes" size="3" value=""> ��
					<input type="text" class="ik" id="speed_seconds" name="speed_seconds" size="3" value=""> ��/����
				</td>
			</tr>
			</table>
			<div class="tj">
					<a id="btn2" class="calcu" onclick="OK()">���� </a>
					<a id="btn" class="calcure" onclick="Clear()">����</a>
					<a id="calorie"></a>				
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
	document.getElementById("distance").value = "";
	document.getElementById("hours").value = "";
	document.getElementById("minutes").value = "";
	document.getElementById("seconds").value = "";
	document.getElementById("speed_minutes").value = "";
	document.getElementById("speed_seconds").value = "";
	document.getElementById("calorie").innerHTML = "";
}
function OK()
{
	var distance = document.getElementById("distance").value;
	var hours = document.getElementById("hours").value;
	var minutes = document.getElementById("minutes").value;
	var seconds = document.getElementById("seconds").value;
	var speed_minutes = document.getElementById("speed_minutes").value;
	var speed_seconds = document.getElementById("speed_seconds").value;
	document.getElementById("calorie").innerHTML = "";
	if(distance.length > 0 && hours.length > 0 && minutes.length > 0 && seconds.length > 0)
	{
		var speed = parseFloat(hours) * 60.0 + parseFloat(minutes) + parseFloat(seconds) / 60.0;
		speed = speed / parseFloat(distance);
		speed_minutes = Math.floor(speed);
		speed_seconds = Math.floor((speed - speed_minutes) * 60.0);
		document.getElementById("speed_minutes").value = speed_minutes;
		document.getElementById("speed_seconds").value = speed_seconds;
		return;
	}
	if(distance.length > 0 && speed_minutes.length > 0 && speed_seconds.length > 0)
	{
		var atime = parseFloat(speed_minutes) + parseFloat(speed_seconds) / 60.0;
		atime = atime * parseFloat(distance);
		hours = Math.floor(atime / 60.0);
		minutes = Math.floor(atime - hours * 60.0);
		seconds = Math.floor((atime - hours * 60.0 - minutes)*60.0);
		document.getElementById("hours").value =  hours;
		document.getElementById("minutes").value = minutes;
		document.getElementById("seconds").value = seconds;
		return;
	}
	if(minutes.length > 0 && seconds.length > 0 && speed_minutes.length > 0 && speed_seconds.length > 0)
	{
		var atime = parseFloat(hours) * 60 + parseFloat(minutes) + parseFloat(seconds) / 60.0;
		var speed = parseFloat(speed_minutes) + parseFloat(speed_seconds) / 60.0;
		//distance = Math.floor(atime / speed);
		distance = atime / speed;
		document.getElementById("distance").value =  distance.toFixed(1);
		return;
	}
	document.getElementById("calorie").innerHTML = "�������ݲ���";
}
</script>
</body>
</html>
