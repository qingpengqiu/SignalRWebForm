<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FinishTime.aspx.cs" Inherits="_Channels_Tools_FinishTime" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>���ܼ�������Finish Time Calculator��</title>
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
				<li><a href="PaceConverter.aspx">����ת������Pace Converter��</a></li>
				<li class="dq"><a href="FinishTime.aspx">���ܼ�������Finish Time��</a></li>
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
			<span>���ܼ�����<em>��Finish Time Calculator��</em></span>
			<p>
				�������Ѿ��ܵľ��롢���ܾ�������ʱ�䡢�ƻ��ܵľ�����������������ƻ���̵�ʱ��<br>
				����ƻ���10�������8�����ʱ40���ӣ�������10�������ʱ����49��58��
			</p>			
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="100">
			<tr>
				<td nowrap align="right">
					���Ѿ��ܵľ��룺
				</td>
				<td nowrap>
					<input type="text" class="ik" id="distance" name="distance" size="3" value=""> ����
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					��ʱ��
				</td>
				<td nowrap>
					<% =GCommon.HMS("hours", 0, 24, 0) %> ʱ
					<% =GCommon.HMS("minutes", 0, 59, 0) %> ��
					<% =GCommon.HMS("seconds", 0, 59, 0) %> ��
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					�ƻ��ܵľ��룺
				</td>
				<td nowrap>
					<input type="text" class="ik" id="distance2" name="distance2" size="3" value=""> ����
				</td>
			</tr>
			</table>
			<div class="tj">
					<a id="btn2" class="calcu" onclick="OK()">���� </a>
					<a id="btn" class="calcure" onclick="Clear()">����</a>
					<a id="calorie"></a>				
			</div>
			<div id="jieguo">
				
			</div>								
			</form>
		</div>
	</div>
</div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
<script language="javascript">
function Clear()
{
	document.getElementById("distance").value = "";
	document.getElementById("distance2").value = "";
	document.getElementById("hours").value = "";
	document.getElementById("minutes").value = "";
	document.getElementById("seconds").value = "";
	document.getElementById("calorie").innerHTML = "";
}
function OK()
{
	var distance = document.getElementById("distance").value;
	var distance2 = document.getElementById("distance2").value;
	var hours = document.getElementById("hours").value;
	var minutes = document.getElementById("minutes").value;
	var seconds = document.getElementById("seconds").value;
	
	document.getElementById("calorie").innerHTML = "";

	if(distance.length > 0 && hours.length>0 && minutes.length > 0 && seconds.length > 0 && distance2.length > 0)
	{
		var speed = parseFloat(hours) * 60.0 + parseFloat(minutes) + parseFloat(seconds) / 60.0;
		//speed = parseFloat(distance2) * speed / parseFloat(distance);
		speed =  speed * Math.pow(parseFloat(distance2)/ parseFloat(distance), 1.06);

		hours = Math.floor(speed / 60.0);
		minutes = Math.floor(speed - hours * 60.0);
		seconds = Math.floor((speed - hours * 60.0 - minutes)*60.0);

		document.getElementById("jieguo").innerHTML = "��ɵ�ʱ���ǣ�" + hours + "ʱ" + minutes + "��"  + seconds + "��";
		return;
	}

	document.getElementById("calorie").innerHTML = "�������ݲ���";
}
</script>
</body>
</html>
