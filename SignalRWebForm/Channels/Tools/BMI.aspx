<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BMI.aspx.cs" Inherits="_Channels_Tools_BMI" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>BMI����ָ����������Body Mass Index Calculator��</title>
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
<div id="H2_w">
	<div id="cal_main">
		<div id="guide">
			<ul>
				<li><a href="PaceCalculator.aspx">���ټ�����<i>��Pace Calculator��</i></a></li>
				<li><a href="PaceConverter.aspx">����ת������Pace Converter��</a></li>
				<li><a href="FinishTime.aspx">���ܼ�������Finish Time��</a></li>
				<li><a href="MarathonPace.aspx">����������ָ��<em>��Marathon Pace��</em></a></li>
				<li><a href="AgeGrade.aspx">����ȼ���������Age-graded��</a></li>
				<li class="dq"><a href="BMI.aspx">BMI����ָ��������</a></li>
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
			<span>BMI����ָ��������<em>��Body Mass Index Calculator��</em></span>
			<p>
			�������أ��������ߣ����ף�������BMI=���أ����/��ߣ��ף�ƽ��<br>
			75KM 175CM BMI=75/1.75��1.75=24.49<br>
			ƫ�ᣨ����18.5����������18.5-24.9����ƫ�أ�25-29.9�������֣�30�����ϣ�
			</p>
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="300">
			<tr>
				<td nowrap align="right">
					��ߣ�
				</td>
				<td nowrap>
					<input type="text" class="ik" id="height" name="height" size="3" value="<% =PageHeight %>"> ����
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					���أ�
				</td>
				<td nowrap>
					<input type="text" class="ik" id="weight" name="weight" size="3" value="<% =PageWeight %>"> ����
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
			<a class="appdownv" href="/down/indexwap.html"><img src="/Html/images/appdownv.jpg"></a>				
			</form>
		</div>
	</div>

	<div style="h_clear"></div>
</div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
<script language="javascript">

function Clear()
{
	document.getElementById("height").value = "";
	document.getElementById("weight").value = "";
	document.getElementById("calorie").innerHTML = "";
}

function OK()
{
	if(document.getElementById("height").value.length > 0 && document.getElementById("weight").value.length > 0)
	{
		var dist = parseInt(document.getElementById("height").value);
		var wght = parseInt(document.getElementById("weight").value);

		var fac = wght / ((dist / 100.0)*(dist / 100.0));

		var fst = "";
		if(fac<18.5) fst = "ƫ��";
		if(fac>=18.5 && fac<25) fst = "����";
		if(fac>=25 && fac<30) fst = "ƫ��";
		if(fac>=30) fst = "����";

		document.getElementById("jieguo").innerHTML = "��������ָ��Ϊ " + fac.toFixed(2) + " ���ڣ�" + fst;
	}
	else
	{
		document.getElementById("calorie").innerHTML = "���ݴ���";
	}
}

</script>
</body>
</html>
