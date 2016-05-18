<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BMR.aspx.cs" Inherits="_Channels_Tools_BMR" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>������л������</title>
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
<div id="H2_w" >
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
				<li><a href="Training.aspx">ѵ��������</a></li>
				<li><a href="Grade.aspx">�����˶�Ա�ȼ�</a></li>
				<li class="dq"><a href="BMR.aspx">������л������</a></li>
				<li><a href="ShoeSize.aspx">Ь����ձ�</a></li>
				<li><a href="Converter.aspx">��Ӣ��ת��</a>	</li>
			</ul>				
			<script language="javascript" src="/common/jtools.js"></script>
		</div>
		<div id="cont">
			<span>������л������</span>
			<p>
			������л�ʣ�Basal Metabolic Rate�����BMR����ָ�������ڰ���״̬��(ͨ��Ϊ����״̬)���ĵ�����������˵����������������������ϡ�<br>
			һ�����뿨·����ȡ��=BMR x �����ָ��
			</p>	
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="100">
			<tr>
				<td nowrap align="right">
					�Ա�
				</td>
				<td nowrap>
					<div class="radio1" id="gender_radio" name="gender_radio" value="male">��</div>
					<div class="radio2" id="gender_radio" name="gender_radio" value="female">Ů</div>
					<input type="hidden" id="gender" name="gender" value="male">
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					��ߣ�
				</td>
				<td nowrap>
					<input type="text" class="ik" id="height" name="height" size="3" value="<% =PageHeight %>"> Cm
					���أ�<input type="text" class="ik" id="weight" name="weight" size="3" value="<% =PageWeight %>"> Kg
					���䣺<input type="text" class="ik" id="age" name="age" size="3" value="<% =PageAge %>"> ��<br>
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					�˶�ϰ�ߣ�
				</td>
				<td nowrap>
					<div class="radio1" id="prf_radio" name="prf_radio" value="1.2" onclick="RadioAction(this)" style="clear:both;">��ʱ�����ڰ칫�ҡ���������ٻ��� ��ȫû���˶����ˡ�</div>
					<div class="radio2" id="prf_radio" name="prf_radio" value="1.3" onclick="RadioAction(this)" style="clear:both;">ż�����˶���ɢ������֡�������̤�࣬ÿ�ܴ�Լ�����˶�1��3�ε��ˡ�</div>
					<div class="radio2" id="prf_radio" name="prf_radio" value="1.5" onclick="RadioAction(this)" style="clear:both;">�г����˶���ϰ�ߣ����ǻ��Ͻ�����ÿ�ܴ�Լ�˶�3��6�ε��ˡ�</div>
					<div class="radio2" id="prf_radio" name="prf_radio" value="1.7" onclick="RadioAction(this)" style="clear:both;">�Ȱ��˶���ÿ���˶�6��7�Σ����ǹ������൱����ˡ�</div>
					<div class="radio2" id="prf_radio" name="prf_radio" value="1.9" onclick="RadioAction(this)" style="clear:both;">������������Ϣ��Ҫ�����Ͷ����൱�����������ˡ�</div>
					<input type="hidden" id="prf" name="prf" value="1.2">
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
	document.getElementById("age").value = "";
	document.getElementById("height").value = "";
	document.getElementById("weight").value = "";
	document.getElementById("calorie").innerHTML = "";
}

function getElementsByName(name) 
{ 
	var returns = document.getElementsByName(name); 
	if(returns.length > 0) return returns; 
	returns = new Array(); 
	var e = document.getElementsByTagName("input"); 
	for(i = 0; i < e.length; i++) {
		if(e[i].getAttribute("name") == name) { 
			returns[returns.length] = e[i]; 
		} 
	} 
	return returns; 
}

function OK()
{
	var gender = document.getElementById("gender").value;
	var prf = document.getElementById("prf").value;
	var age = document.getElementById("age").value;
	var height = document.getElementById("height").value;
	var weight = document.getElementById("weight").value;
	
	document.getElementById("calorie").innerHTML = "";

	if(age.length > 0 && height.length > 0 && weight.length > 0)
	{
		$.get("/channels/tools/ajax/bmr.aspx", { gender:gender, age:age, height:height, weight:weight, prf:prf }, function(result) {
			document.getElementById("jieguo").innerHTML = result;
		});

		return;
	}

	document.getElementById("calorie").innerHTML = "�������ݲ���";
}
Bind();
</script>
</body>
</html>
