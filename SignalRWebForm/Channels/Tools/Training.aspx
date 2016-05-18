<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Training.aspx.cs" Inherits="_Channels_Tools_Training" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>ѵ����������Training Calculator��</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
<meta name="keywords" content="2013���Ź���������,����,���Ӿ���,����ָ��,�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<link href="/Common/tools.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="/Common/jQuery.js?2012111"></script>
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>	
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
<!--�ڶ���-->
<div id="H2_w">
	<div id="cal_main">
		<div id="guide">
			<ul>
				<li><a href="PaceCalculator.aspx">���ټ�������Pace Calculator��</a></li>
				<li><a href="PaceConverter.aspx">����ת������Pace Converter��</a></li>
				<li><a href="FinishTime.aspx">���ܼ�������Finish Time��</a></li>
				<li><a href="MarathonPace.aspx">����������ָ��<em>��Marathon Pace��</em></a></li>
				<li><a href="AgeGrade.aspx">����ȼ���������Age-graded��</a></li>
				<li><a href="BMI.aspx">BMI����ָ��������</a></li>
				<li><a href="Calorie.aspx">��·���������Calorie��</a></li>
				<li class="dq"><a href="Training.aspx">ѵ��������</a></li>
				<li><a href="Grade.aspx">�����˶�Ա�ȼ�</a></li>
				<li><a href="BMR.aspx">������л������</a></li>
				<li><a href="ShoeSize.aspx">Ь����ձ�</a></li>
				<li><a href="Converter.aspx">��Ӣ��ת��</a>	</li>
			</ul>			
			<script language="javascript" src="/common/jtools.js"></script>	
		</div>
		<div id="cont">
			<span>ѵ��������<em>��Training Calculator��</em></span>
			<p>
			
			</p>	
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="100" autocomplete="off">
			<tr>
				<td nowrap align="right">
					���µ��ܲ����룺
				</td>
				<td nowrap>
					<input type="text" class="ik" id="distance" name="distance" size="3" value=""> ����
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					���µ��ܲ���ʱ��
				</td>
				<td nowrap>
					<% =GCommon.HMS("hours", 0, 24, 0) %> ʱ
					<% =GCommon.HMS("minutes", 0, 59, 0) %> ��
					<% =GCommon.HMS("seconds", 0, 59, 0) %> ��
				</td>
			</tr>
			<tr>
				<td nowrap>
				</td>
				<td id="calorie" nowrap>
				</td>
			</tr>
			</table>
			<div class="tj">
					<a id="btn2" class="calcu" onclick="OK()">���� </a>
					<a id="btn" class="calcure" onclick="Clear()">����</a>
					<a id="calorie"></a>				
			</div>
			<div id="jieguo">
				Ԥ����ʱ��
					<table id="tab2" width="482" border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0">
					<tr class="title">
						<td colspan="2">��ʱ</td>
						<td colspan="2">����</td>
					</tr>
					<tr>
						<td width="25%">1.5 Km</td>
						<td width="25%"id="s1">&nbsp;</td>
						<td width="25%"id="p1">&nbsp;</td>
						<td width="25%">����/��</td>
					</tr>
					<tr>
						<td>3 Km</td>
						<td id="s2">&nbsp;</td>
						<td id="p2">&nbsp;</td>
						<td>����/Сʱ</td>
					</tr>
					<tr>
						<td>5 Km</td>
						<td id="s3">&nbsp;</td>
						<td id="p3">&nbsp;</td>
						<td>��/��</td>
					</tr>
					<tr>
						<td>10 Km</td>
						<td id="s4">&nbsp;</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>���������</td>
						<td id="s5">&nbsp;</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>ȫ��������</td>
						<td id="s6">&nbsp;</td>
						<td></td>
						<td></td>
					</tr>
					</table>							
			</div>					
			</form>
		</div>
	</div>

	<div style="h_clear"></div>
</div>

<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />

<script language="javascript">

function Clear()
{
	document.getElementById("distance").value = "";
	document.getElementById("hours").value = "";
	document.getElementById("minutes").value = "";
	document.getElementById("seconds").value = "";
	document.getElementById("calorie").innerHTML = "";
}

function OK()
{
	var distance = document.getElementById("distance").value;
	var hours = document.getElementById("hours").value;
	var minutes = document.getElementById("minutes").value;
	var seconds = document.getElementById("seconds").value;

	document.getElementById("calorie").innerHTML = "";

	if(distance.length > 0 && hours.length > 0 && minutes.length > 0 && seconds.length > 0)
	{
		// ����ÿ������ٶ�
		var speed = parseFloat(hours) * 60.0 + parseFloat(minutes) + parseFloat(seconds) / 60.0;
		//var speed2 = speed;
		//speed = speed / parseFloat(distance);

		//T2 = T1 x (D2/D1)^1.06;
		// speed = Math.pow(, 1.06);
		document.getElementById("s1").innerHTML = MinuteToHMS(speed * Math.pow(1.5 / parseFloat(distance), 1.06));
		document.getElementById("s2").innerHTML = MinuteToHMS(speed * Math.pow(3.0 / parseFloat(distance), 1.06));
		document.getElementById("s3").innerHTML = MinuteToHMS(speed * Math.pow(5.0 / parseFloat(distance), 1.06));
		document.getElementById("s4").innerHTML = MinuteToHMS(speed * Math.pow(10.0 / parseFloat(distance), 1.06));
		document.getElementById("s5").innerHTML = MinuteToHMS(speed * Math.pow(21.1 / parseFloat(distance), 1.06));
		document.getElementById("s6").innerHTML = MinuteToHMS(speed * Math.pow(42.195 / parseFloat(distance), 1.06));

		speed = speed / parseFloat(distance);
		document.getElementById("p1").innerHTML = (1.0/speed).toFixed(2);
		document.getElementById("p2").innerHTML = (60.0/speed).toFixed(2);
		document.getElementById("p3").innerHTML = (1000.0/speed/60.0).toFixed(2);
		return;
	}

	document.getElementById("calorie").innerHTML = "�������ݲ���";
}

function I2(v)
{
	return (v<10) ? "0" + v : v;
}

function MinuteToHMS(atime)
{
	var hours = Math.floor(atime / 60.0);
	var minutes = Math.floor(atime - hours * 60.0);
	var seconds = Math.floor((atime - hours * 60.0 - minutes) * 60.0)
	return I2(hours) + ":" + I2(minutes) + ":" + I2(seconds);
}

</script>

</center>
</body>
</html>
