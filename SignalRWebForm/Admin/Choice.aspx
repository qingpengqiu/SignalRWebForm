<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Choice.aspx.cs" Inherits="Admin_Choice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>����ά��-������</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Admin.css" type="text/css" rel="stylesheet" />
</head>
<body>
<center>

<ERUN360:header_user id="header_user" runat="server" />

<div style="width:930px;height:600px;padding:10px;text-align:left;">

	<div style="padding:10px;height:32px;font-size:12px;">
		<a href="/">��ҳ</a> >
		<a href="/admin/">������ҳ</a> > 
		�༭��ҳ���ܾ�ѡ
	</div>


	<!-- ��Ϣ���뿪ʼ -->
	<form id="form1" name="form1" action="Choice.aspx" method="post">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
	<tr>
		<td style="border-top:dotted 1px #AAAAAA;padding:20px;padding-left:3px;color:#666666;font-size:12px;">
			<!--����-->
			��ο�����ʵ��������ҳ�����������ݣ�HTML��ʽ����<br>

&lt;ul class="zhuanti"&gt;<br>
&lt;li&gt;<br>
&lt;a href="" class="zttitle"&gt;��ר�⡿�ܰ��޽� ��ǿ֣ƽ&lt;/a&gt;<br>
&lt;a href=""&gt;[������֣ƽ��ǿ]&lt;/a&gt;<br>
&lt;a href=""&gt;[ѪԴ��ȱ ֣ƽ�漱]&lt;/a&gt;<br>
&lt;a href=""&gt;[�����ж� ��������]&lt;/a&gt;<br>
&lt;a href=""&gt;[����֣ƽ �����ѹ�]&lt;/a&gt;<br>
&lt;/li&gt;<br>
&lt;li&gt;<br>
&lt;a href="" class="zttitle"&gt;��ר�⡿�ܰ��޽� ��ǿ֣ƽ&lt;/a&gt;<br>
&lt;a href=""&gt;[������֣ƽ��ǿ]&lt;/a&gt;<br>
&lt;a href=""&gt;[ѪԴ��ȱ ֣ƽ�漱]&lt;/a&gt;<br>
&lt;a href=""&gt;[�����ж� ��������]&lt;/a&gt;<br>
&lt;a href=""&gt;[����֣ƽ �����ѹ�]&lt;/a&gt;<br>
&lt;/li&gt;<br>
&lt;/ul&gt;
		</td>
		<td colspan="2" align="left" valign="top" style="color:#5C6F9A;padding:20px;border-top:dotted 1px #AAAAAA;font-size:12px;">
			<br>
			&bull; ��һ�����������ǿ��ʾ���� class="zttitle" ���Ρ�<br>
			&bull; ���������&lt;br&gt;������<br>
		</td>
	</tr>
	<tr>
		<td>
			<textarea id="cContent" name="cContent" cols="70" rows="16"><% =PageBuffer %></textarea> 
		</td>
		<td nowrap width="100" align="center">
			<img src="/Images/preview.gif" onclick="Preview()">
		</td>
		<td>
			<style>
			#preview { width:330px;height:182px;padding-top:5px;text-align:left;overflow:hidden; }
.zhuanti{margin-bottom: -1px;padding-top: 2px;font-family:΢���ź�,����;padding-left:0px;}
.zhuanti li{border-bottom: 1px  dashed #dddddd;line-height: 24px;padding:  5px 0 ;}
.zhuanti li a{font-size: 15px;}
.zhuanti li .zttitle{font-size: 15px; color: #438dc3;font-weight: bold;}			
			</style>
			<div style="border:dotted 1px #EEEEFF;">
			<div id="preview"></div>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
			<div style="float:left;width:100px;height:32px;">
				<img src="/Images/submit.gif" onclick="Finish()">
			</div>
			<div id="total_echo" style="float:left;width:300px;height:22px;padding-top:10px;" class="check_echo">
			<% =PageResult %>
			</div>
		</td>
		<td>
		</td>	
	</tr>
	</table>
	</form>

<!-- ��Ϣ�������javascript���룬��jQuery֧�� -->
<script language="javascript">

    function Preview() {
        //alert($("#cContent")[0].value);
        $("#preview").html($("#cContent")[0].value);
    }

    function Finish() {
        if ($("#preview")[0].innerHTML.length < 1) {
            alert("���ȵ��Ԥ��");
            return false;
        }

        var check_num = 1;
        var obj = $("#cContent")[0];
        if (NullCheck(obj)) if (StringCheck(obj)) { check_num--; }
        if (check_num == 0) {
            document.form1.submit();
            return true;
        }
        else {
            $("#total_echo").html("���а����ύ���ݻ��д���Ŷ��");
        }
        return false;
    }

</script>
</center>

</body>
</html>
