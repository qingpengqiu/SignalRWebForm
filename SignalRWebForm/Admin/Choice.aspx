<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Choice.aspx.cs" Inherits="Admin_Choice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新闻维护-益跑网</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Admin.css" type="text/css" rel="stylesheet" />
</head>
<body>
<center>

<ERUN360:header_user id="header_user" runat="server" />

<div style="width:930px;height:600px;padding:10px;text-align:left;">

	<div style="padding:10px;height:32px;font-size:12px;">
		<a href="/">首页</a> >
		<a href="/admin/">管理首页</a> > 
		编辑首页益跑精选
	</div>


	<!-- 信息输入开始 -->
	<form id="form1" name="form1" action="Choice.aspx" method="post">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
	<tr>
		<td style="border-top:dotted 1px #AAAAAA;padding:20px;padding-left:3px;color:#666666;font-size:12px;">
			<!--例子-->
			请参考下面实例输入首页新闻区块内容（HTML格式）：<br>

&lt;ul class="zhuanti"&gt;<br>
&lt;li&gt;<br>
&lt;a href="" class="zttitle"&gt;【专题】跑爱无疆 坚强郑平&lt;/a&gt;<br>
&lt;a href=""&gt;[爱，让郑平坚强]&lt;/a&gt;<br>
&lt;a href=""&gt;[血源短缺 郑平告急]&lt;/a&gt;<br>
&lt;a href=""&gt;[接力行动 美名流传]&lt;/a&gt;<br>
&lt;a href=""&gt;[寄语郑平 共度难关]&lt;/a&gt;<br>
&lt;/li&gt;<br>
&lt;li&gt;<br>
&lt;a href="" class="zttitle"&gt;【专题】跑爱无疆 坚强郑平&lt;/a&gt;<br>
&lt;a href=""&gt;[爱，让郑平坚强]&lt;/a&gt;<br>
&lt;a href=""&gt;[血源短缺 郑平告急]&lt;/a&gt;<br>
&lt;a href=""&gt;[接力行动 美名流传]&lt;/a&gt;<br>
&lt;a href=""&gt;[寄语郑平 共度难关]&lt;/a&gt;<br>
&lt;/li&gt;<br>
&lt;/ul&gt;
		</td>
		<td colspan="2" align="left" valign="top" style="color:#5C6F9A;padding:20px;border-top:dotted 1px #AAAAAA;font-size:12px;">
			<br>
			&bull; 第一个新闻如需加强显示加入 class="zttitle" 修饰。<br>
			&bull; 换行请加入&lt;br&gt;描述。<br>
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
.zhuanti{margin-bottom: -1px;padding-top: 2px;font-family:微软雅黑,宋体;padding-left:0px;}
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

<!-- 信息输入相关javascript代码，需jQuery支持 -->
<script language="javascript">

    function Preview() {
        //alert($("#cContent")[0].value);
        $("#preview").html($("#cContent")[0].value);
    }

    function Finish() {
        if ($("#preview")[0].innerHTML.length < 1) {
            alert("请先点击预览");
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
            $("#total_echo").html("不行啊！提交数据还有错误哦！");
        }
        return false;
    }

</script>
</center>

</body>
</html>
