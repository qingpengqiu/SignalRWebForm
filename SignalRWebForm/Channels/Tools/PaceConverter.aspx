<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaceConverter.aspx.cs" Inherits="_Channels_Tools_PaceConverter" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>����ת������Pace Converter��</title>
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
<div id="H2_w" >
	<div id="cal_main">
		<div id="guide">
			<ul>
				<li><a href="PaceCalculator.aspx">���ټ�������Pace Calculator��</a></li>
				<li class="dq"><a href="PaceConverter.aspx">����ת������Pace Converter��</a></li>
				<li><a href="FinishTime.aspx">���ܼ�������Finish Time��</a></li>
				<li><a href="MarathonPace.aspx">����������ָ�ϣ�Marathon Pace��</a></li>
				<li><a href="AgeGrade.aspx">����ȼ���������Age-graded��</a></li>
				<li><a href="BMI.aspx">BMI����ָ��������</a></li>
				<li><a href="Calorie.aspx">��·���������Calorie��</a></li>
				<li><a href="Training.aspx">ѵ��������</a></li>
				<li><a href="Grade.aspx">�����˶�Ա�ȼ�</a></li>
				<li><a href="BMR.aspx">������л������</a></li>
				<li><a href="ShoeSize.aspx">Ь����ձ�</a></li>
				<li><a href="Converter.aspx">��Ӣ��ת��</a>	</li>
			</ul>				
			<script language="javascript" src="/common/jtools.js"></script>
		</div>
		<div id="cont">
			<span>����ת��/������<em>��Pace Converter��</em></span>
			<p>
�������٣����֣���/���������/Сʱ����/���е�����һ�������������
���磺1����/Сʱ=5/18��/��=60��0��/���� 3.33��/��=12����/Сʱ=5��/����
			</p>
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="100">
			<tr>
				<td nowrap>
					��ʽ1��
				</td>
				<td nowrap>
					<input type="text" class="ik" id="mm" name="mm" size="3" value=""> �� 
					<input type="text" class="ik" id="ss" name="ss" size="3" value=""> ��/����<br>
				</td>
			</tr>
			<tr>
				<td nowrap>
					��ʽ2��
				</td>
				<td nowrap>
					<input type="text" class="ik" id="km" name="km" size="3" value=""> ����/Сʱ<br>
				</td>
			</tr>
			<tr>
				<td nowrap>
					��ʽ3��
				</td>
				<td nowrap>
					<input type="text" class="ik" id="ms" name="ms" size="3" value=""> ��/��<br>
				</td>
			</tr>
			</table>
			<div class="tj">
					<a id="btn2" class="calcu" onclick="OK()">���� </a>
					<a id="btn" class="calcure" onclick="Clear()">����</a>
					<a id="calorie"></a>				
			</div>				
			</form>
		</div>
	</div>
</div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
<script language="javascript">

function Clear()
{
	//document.getElementById("hh").value = "0";
	document.getElementById("mm").value = "";
	document.getElementById("ss").value = "";
	document.getElementById("km").value = "";
	document.getElementById("ms").value = "";
}

function OK()
{
	document.getElementById("calorie").innerHTML = "";

	var speed = 0.0;
	if(document.getElementById("mm").value.length > 0 && document.getElementById("ss").value.length > 0)
	{
		speed = parseFloat(document.getElementById("mm").value) + parseFloat(document.getElementById("ss").value) / 60.0;

		document.getElementById("km").value = (60.0 / speed).toFixed(2);
		document.getElementById("ms").value = (1000.0 / speed / 60.0).toFixed(2);
		return;
	}

	if(document.getElementById("km").value.length > 0)
	{
		speed = parseFloat(document.getElementById("km").value);
		var atime = 60.0 / speed;
		var stime = MinutesToHms(atime);
		document.getElementById("mm").value = I2(stime.hours * 60 + stime.minutes);
		document.getElementById("ss").value = I2(stime.seconds);
		document.getElementById("ms").value = (1000.0 * speed / 3600.0).toFixed(2);
		return;
	}

	if(document.getElementById("ms").value.length > 0)
	{
		speed = parseFloat(document.getElementById("ms").value);
		var atime =  1000.0 / speed / 60.0;
		var stime = MinutesToHms(atime);
		document.getElementById("mm").value = I2(stime.hours * 60 + stime.minutes);
		document.getElementById("ss").value = I2(stime.seconds);
		document.getElementById("km").value = (3600.0 * speed / 1000.0).toFixed(2);
		return;
	}

	document.getElementById("calorie").innerHTML = "�������ݲ���";
}

</script>
</body>
</html>
