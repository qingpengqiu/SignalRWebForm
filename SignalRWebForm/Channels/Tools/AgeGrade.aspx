<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AgeGrade.aspx.cs"  Debug="true" Inherits="_Channels_Tools_AgeGrade" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>����ȼ���������Age-graded Calculator��</title>
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
				<li class="dq"><a href="AgeGrade.aspx">����ȼ���������Age-graded��</a></li>
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
			<span>����ȼ�������<em>��Age-graded Calculator��</em></span>
			<p>
				�����Ա����䡢�ܲ����롢��ʱ�����������ȼ��÷�,����ȼ���ʱ�ȡ����缶��ͬ����ĳɼ���WMA Age-grading calculator 2006�ṩ��
				����ȼ��÷������ĳɼ����������������λ�ã�����ȼ���ʱ�Ƕ����飨25�꣩Ҫ�ﵽ���ĵȼ��÷�����Ҫ��ʱ�䡣
				�ȼ��÷֣�100% �����¼ˮƽ >90% ����ˮƽ >80% ȫ��ˮƽ >70% ����ˮƽ >60% ����ˮƽ
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
					���䣺
				</td>
				<td nowrap>
					<input type="text" class="ik" id="age" name="age" size="3" maxlength="2" value="<% =PageAge %>">
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					���ˣ�
				</td>
				<td nowrap>
					<!--
					<option value="walk">**����**</option>
					<option value="3kmwalk">��3km</option>
					<option value="5kmwalk">��5km</option>
					<option value="10kmwalk">��10km</option>
					<option value="15kmwalk">��15km</option>
					<option value="20kmwalk">��20km</option>
					<option value="halfmarathonwalk">�����������</option>
					<option value="25kmwalk">��25km</option>
					<option value="30kmwalk">��30km</option>
					<option value="40kmwalk">��40km</option>
					<option value="marathonwalk">��ȫ��������</option>
					<option value="50kmwalk">��50km</option>
					<option value="run">**�ܲ�**</option>
					<option value="road">**ԽҰ**</option>
					<option value="5km">��5km</option>
					<option value="8km">��8km</option>
					<option value="10km">��10km</option>
					-->
					<select id="style" name="style" class="ik" style="width:180px;">
					<option value="500m">500m</option>
					<option value="1000m">1000m</option>
					<option value="3km">3km</option>
					<option value="5kmroad">5km</option>
					<option value="8kmroad">8km</option>
					<option value="10kmroad">10km</option>
					<option value="15km">15km</option>
					<option value="20km">20km</option>
					<option value="halfmarathon">���������</option>
					<option value="30km">30km</option>
					<option value="marathon">ȫ��������</option>
					<option value="50km">50km</option>
					<option value="100km">100km</option>
					<option value="150km">150km</option>
					<option value="200km">200km</option>
					</select>
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
	document.getElementById("hours").value = "";
	document.getElementById("minutes").value = "";
	document.getElementById("seconds").value = "";
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
	//var gobj = getElementsByName("gender");
	//var gender = (gobj[0].checked) ? "male" : "female";
	var gender = document.getElementById("gender").value;
	var style = document.getElementById("style").options[document.getElementById("style").selectedIndex].value;
	var age = document.getElementById("age").value;
	var hours = document.getElementById("hours").value;
	var minutes = document.getElementById("minutes").value;
	var seconds = document.getElementById("seconds").value;
	
	document.getElementById("calorie").innerHTML = "";

	if(age.length > 0 && hours.length > 0 && minutes.length > 0 && seconds.length > 0)
	{
		var speed = parseInt(hours) * 3600 + parseInt(minutes) * 60 + parseInt(seconds);
		$.get("/channels/tools/ajax/agegrade.aspx", { gender : gender, style : style, age : age, seconds : speed }, function(result) {
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
