<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Member_Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>ע��-������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
<meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
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
		<em>�Ѿ���������ע���Ա <a href="/Member/Login.aspx"><img src="/images/regis/dl.png" alt=""> </a></em>
		<a href="/" class="logo"></a>
		<div class="zclx">
			�û�ע��
		</div>
<form id="form1" name="form1" action="Default.aspx" method="post" autocomplete="off">
	<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
	<tr>
		<td align="right">�ǳ�</td>
		<td width="486">
			<input type="text" id="cLoginName" name="cLoginName" maxlength="32"  value="" onblur="if(NullCheck(this)) if(StringCheck(this)) if(LengthCheck(this,2,32)) DuplicateCheck(this);" onclick="$('#check_' + this.id).html('<font>����Ϊ2-32�����ú��пո񼰷Ƿ�����</font>');"> 
			<span id="check_cLoginName" class="check_echo"></span>
		</td>
	</tr>	
	<tr>
		<td align="right">����</td>
		<td>
			<input type="password" id="cPassword" name="cPassword" maxlength="32"  value="" onblur="if(NullCheck(this)) if(LengthCheck(this,6,32)) StringCheck(this);" onclick="$('#check_' + this.id).html('<font>����Ϊ6-32,����ĸ���������</font>');"> 
			<span id="check_cPassword" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right">�ظ�����</td>
		<td>
			<input type="password" id="cPassword2" name="cPassword2" maxlength="32"  value="" onblur="if(NullCheck(this)) if(LengthCheck(this,6,32)) if(StringCheck(this)) SameCheck(this,'cPassword');" onclick="$('#check_' + this.id).html('<font>ͬ��</font>');"> 
			<span id="check_cPassword2" class="check_echo"></span>
		</td>
	</tr>	
	<tr>
		<td align="right" class="xming" >����</td>
		<td class="xming" >
			<input type="text" id="cName" name="cName" maxlength="255"  value="" onblur="if(NullCheck(this)) if(LengthCheck(this,2,16)) StringCheck(this);" onclick="$('#check_' + this.id).html('<font>������ʵ����</font>');"> 
			<span id="check_cName" class="check_echo"></span>
		</td>
	</tr>		
	<tr>
		<td align="right" valign="top" class="xbie" >�Ա�</td>
		<td class="xbie" >
<% =GCommon.Controls("�Ա�","radio", "idGender", "0") %>
		</td>
	</tr>
	<tr>
		<td align="right">����</td>
		<td>
			<input type="text" id="dBirthday" name="dBirthday" maxlength="255"  readonly value="ѡ������" onclick="GDate(this);" style="cursor:pointer;"> 
		</td>
	</tr>
	<tr>
		<td align="right" class="mmwttd">�ܱ�����</td>
		<td class="mmwttd">
			<div class="mmwt">
			<select onchange="UpdateHistory(this)" name="idQuestion" id="idQuestion" value="ѡ������" >
				<option value="0">���ֻ�����ĺ�6λ</option>
				<option value="1">��ĸ�׵�����</option>
				<option value="2">�Ҹ��׵�����</option>
				<option selected="" value="3">�ҵ��ܲ�����</option>
				<option value="4">�ҵ�һ�������ɳɼ�</option>
				<option value="5">�ҵ�һ�βμ������ɵ�ʱ��</option>
				<option value="6">�ҵ�һ�βμ������ɵ�����</option>
				<option value="7">����ϲ������Ь�ͺ�</option>
				<option value="8">����ϲ�����ܲ�����</option>
				<option value="9">����ϲ�����ܲ��ص�</option>
				<option value="10">����ϲ����С˵</option>
			</select>
			</div>
			��
			<input type="text" id="cAnswer" name="cAnswer" size="16" maxlength="255"  value="" onblur="if(NullCheck(this)) if(LengthCheck(this,4,32)) StringCheck(this);" onclick="$('#check_' + this.id).html('<font>����</font>');"> 
			<span id="check_cAnswer" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right"></td>
		<td class="xyi">
			<input checked="checked" type="checkbox" id="inputCheck" name="after" />���Ѿ�������ͬ��<a href="/channels/about/lawyer.aspx" target="_blank">������������ʹ��Э�顷</a>
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
    <a title="" href="http://www.erun360.com/">������ҳ</a> -  <a title="" href="http://www.erun360.com/channels/about/">��������</a> -  <a title="" href="http://www.erun360.com/channels/about/contact.aspx">��ϵ����</a> -  <a title="" href="http://www.erun360.com/channels/about/job.aspx">��������</a> -  <a title="" href="http://www.erun360.com/member/">��Ա����</a><br>
    ������ ��ICP��12042185�� Copyright &copy;2012����������Ϣ�������޹�˾ ��Ȩ����
    </div>
	</div>
<script language="javascript">
var dupChecked = false;
function DuplicateCheck(obj)
{
    $.post("/Utility/Ajax/MemberDuplicate.aspx", { cloginname: obj.value }, function(result) {
        if (result == "OK") {
            dupChecked = false;
            $("#check_" + obj.id).html(imgErr + "�޷�ʹ�øõ�¼����");
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
		$("#total_echo").html("������������Ŷ��");
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
		$("#total_echo").html("���а����ύ���ݻ��д���Ŷ��");
	}
    return false;
}
</script>
<script src="http://s14.cnzz.com/stat.php?id=4723271&web_id=4723271&show=pic" language="JavaScript"></script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("a[title='վ��ͳ��']").hide();
        });
    </script>
</body>
</html>
