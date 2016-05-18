<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Converter.aspx.cs" Inherits="_Channels_Tools_Converter" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>��Ӣ��ת��</title>
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
				<li><a href="FinishTime.aspx">���ܼ�������Finish Time��</a></li>
				<li><a href="MarathonPace.aspx">����������ָ��<em>��Marathon Pace��</em></a></li>
				<li><a href="AgeGrade.aspx">����ȼ���������Age-graded��</a></li>
				<li><a href="BMI.aspx">BMI����ָ��������</a></li>
				<li><a href="Calorie.aspx">��·���������Calorie��</a></li>
				<li><a href="Training.aspx">ѵ��������</a></li>
				<li><a href="Grade.aspx">�����˶�Ա�ȼ�</a></li>
				<li><a href="BMR.aspx">������л������</a></li>
				<li><a href="ShoeSize.aspx">Ь����ձ�</a></li>
				<li class="dq"><a href="Converter.aspx">��Ӣ��ת��</a>	</li>
			</ul>	
			<script language="javascript" src="/common/jtools.js"></script>	
		</div>
		<div id="cont">
			<span>��Ӣ��ת��</span>			
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
				<ul>
					<li>
						<span id="btn" onclick="Clear1()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="mile" name="mile" size="3" value=""> Ӣ��
						<span id="btn2" onclick="OK1()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="km" name="km" size="3" value=""> ����
						
					</li>
					<li>
						<span id="btn" onclick="Clear2()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="foot" name="foot" size="3" value=""> Ӣ��
						<span id="btn2" onclick="OK2()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="cm2" name="cm2" size="3" value=""> ����
						
					</li>
					<li>
						<span id="btn" onclick="Clear3()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="inch" name="inch" size="3" value=""> Ӣ��
						<span id="btn2" onclick="OK3()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="cm3" name="cm3" size="3" value=""> ����
						
					</li>
					<li>
						<span id="btn" onclick="Clear4()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="pound" name="pound" size="3" value=""> Ӣ��
						<span id="btn2" onclick="OK4()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="kg" name="kg" size="3" value=""> ����
						
					</li>
					<li>
						<span id="btn" onclick="Clear5()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="oz" name="oz" size="3" value=""> ��˾
						<span id="btn2" onclick="OK5()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="g" name="g" size="3" value=""> ��
						
					</li>
					<li>
						<span id="btn" onclick="Clear6()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="clm" name="clm" size="3" value=""> ���� 
						<span id="btn2" onclick="OK6()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="sh" name="sh" size="3" value=""> ��
						
					</li>
				</ul>
			</form>
		</div>
	</div>
</div>

<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />

<script language="javascript">

function Clear1()
{
	document.getElementById("mile").value = "";
	document.getElementById("km").value = "";
}

function OK1()
{
	if(document.getElementById("mile").value != "")
	{
		document.getElementById("km").value = (parseFloat(document.getElementById("mile").value) * 1.609).toFixed(2);
		return;
	}

	if(document.getElementById("km").value != "")
	{
		document.getElementById("mile").value = (parseFloat(document.getElementById("km").value) / 1.609).toFixed(2);
		return;
	}
}

function Clear2()
{
	document.getElementById("foot").value = "";
	document.getElementById("cm2").value = "";
}

function OK2()
{
	if(document.getElementById("foot").value != "")
	{
		document.getElementById("cm2").value = (parseFloat(document.getElementById("foot").value) * 2.54).toFixed(2);
		return;
	}

	if(document.getElementById("cm2").value != "")
	{
		document.getElementById("foot").value = (parseFloat(document.getElementById("cm2").value) / 2.54).toFixed(2);
		return;
	}
}

function Clear3()
{
	document.getElementById("inch").value = "";
	document.getElementById("cm3").value = "";
}

function OK3()
{
	if(document.getElementById("inch").value != "")
	{
		document.getElementById("cm3").value = (parseFloat(document.getElementById("inch").value) * 2.54 * 12.0).toFixed(2);
		return;
	}

	if(document.getElementById("cm3").value != "")
	{
		document.getElementById("inch").value = (parseFloat(document.getElementById("cm3").value) / 2.54 / 12.0).toFixed(2);
		return;
	}
}

function Clear4()
{
	document.getElementById("pound").value = "";
	document.getElementById("kg").value = "";
}

function OK4()
{
	if(document.getElementById("pound").value != "")
	{
		document.getElementById("kg").value = (parseFloat(document.getElementById("pound").value) * 0.45359237).toFixed(2);
		return;
	}

	if(document.getElementById("kg").value != "")
	{
		document.getElementById("pound").value = (parseFloat(document.getElementById("kg").value) / 0.45359237).toFixed(2);
		return;
	}
}


function Clear5()
{
	document.getElementById("oz").value = "";
	document.getElementById("g").value = "";
}

function OK5()
{
	if(document.getElementById("oz").value != "")
	{
		document.getElementById("g").value = (parseFloat(document.getElementById("oz").value) * 28.349523125).toFixed(2);
		return;
	}

	if(document.getElementById("g").value != "")
	{
		document.getElementById("oz").value = (parseFloat(document.getElementById("g").value) / 28.349523125).toFixed(2);
		return;
	}
}

function Clear6()
{
	document.getElementById("clm").value = "";
	document.getElementById("sh").value = "";
}

function OK6()
{
	if(document.getElementById("clm").value != "")
	{
		document.getElementById("sh").value = (parseFloat(document.getElementById("clm").value) * 3.785411784).toFixed(2);
		return;
	}

	if(document.getElementById("sh").value != "")
	{
		document.getElementById("clm").value = (parseFloat(document.getElementById("sh").value) / 3.785411784).toFixed(2);
		return;
	}
}
</script>
</body>
</html>
