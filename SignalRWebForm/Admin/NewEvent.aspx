<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewEvent.aspx.cs" Inherits="Admin_NewEvent" %>

<!DOCTYPE html>

<html>
<head>
    <title>���±���ά��-������</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <link href="/Common/Admin.css" type="text/css" rel="stylesheet" /> 
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <style>
.event{padding: 6px 0}
.event li{padding:6px 10px 6px 18px;color: #666;font-size: 12px;display: block;}
.event li .title{display: inline-block;font-size: 14px;color: #4C98CC;line-height: 16px;font-family:\5FAE\8F6F\96C5\9ED1  ;padding-left: 19px}
.event li p{padding: 4px 0 0 18px;height: 19px;margin:0}
.event li:hover img{display: inline-block;}
.event li img{float: right;margin-right: 10px;display: none}
.seroption{padding: 15px 30px;background-color: rgba(255, 255, 204, 0.15)}
.event li .title span{height: 15px;display: inline-block;width: 15px;margin:0px 4px -2px 0px;overflow: hidden;margin-left: -19px;}
        #comp_icon_u { background: url(/Html/images/comp_icon_v.png);} 
#comp_icon_m { background: url(/Html/images/comp_icon_m.png);} 
#comp_icon_h { background: url(/Html/images/comp_icon_h.png);} 
#comp_icon_r { background: url(/Html/images/comp_icon_r.png);} 
#comp_icon_c { background: url(/Html/images/comp_icon_c.png);} 
#comp_icon_t { background: url(/Html/images/comp_icon_t.png);} 
    </style>
</head>
<body>
    <center>

<ERUN360:header_user id="header_user" runat="server" />

<div style="width:930px;height:600px;padding:10px;text-align:left;">

	<div style="padding:10px;height:32px;font-size:12px;">
		<a href="/" >��ҳ</a>  >
<a href="/Admin/RaceList.aspx">������ҳ</a>>
		�༭��ҳ���±���
	</div>


	<!-- ��Ϣ���뿪ʼ -->
	<form id="form1" name="form1" action="NewEvent.aspx" method="post">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
	<tr>
		<td style="border-top:dotted 1px #AAAAAA;padding:20px;padding-left:3px;color:#666666;font-size:12px;">
			<!--����-->
			��ο�����ʵ��������ҳ���±����������ݣ�HTML��ʽ����<br>
&lt;li&gt;<br>
           &lt;p&gt;&lt;a class="title" target="_blank" href="/blog/200018532.aspx"&gt;&lt;span id="comp_icon_c"&gt; &lt;/span&gt;2014�������Ѹ�ǧ����������֪�к�������&lt;/a&gt;&lt;/p&gt;<br />
            &lt;p&gt;����ʱ�䣺2014-11-15&lt;a href="/Channels/Competetion/RaceProject.aspx?idcompete=300000508"&gt;&lt;img src="/Html/images/lbm.png"/&gt;&lt;/a&gt;&lt;/p&gt;<br />
            &lt;/li&gt;<br>
            &lt;li&gt;<br>
           &lt;p&gt;&lt;a class="title" target="_blank" href="/blog/200018532.aspx"&gt;&lt;span id="comp_icon_c"&gt; &lt;/span&gt;2014�������Ѹ�ǧ����������֪�к�������&lt;/a&gt;&lt;/p&gt;<br />
            &lt;p&gt;����ʱ�䣺2014-11-15&lt;a href="/Channels/Competetion/RaceProject.aspx?idcompete=300000508"&gt;&lt;img src="/Html/images/lbm.png"/&gt;&lt;/a&gt;&lt;/p&gt;<br />
            &lt;/li&gt;<br>
            &lt;li&gt;<br>
           &lt;p&gt;&lt;a class="title" target="_blank" href="/blog/200018532.aspx"&gt;&lt;span id="comp_icon_c"&gt; &lt;/span&gt;2014�������Ѹ�ǧ����������֪�к�������&lt;/a&gt;&lt;/p&gt;<br />
            &lt;p&gt;����ʱ�䣺2014-11-15&lt;a href="/Channels/Competetion/RaceProject.aspx?idcompete=300000508"&gt;&lt;img src="/Html/images/lbm.png"/&gt;&lt;/a&gt;&lt;/p&gt;<br />
            &lt;/li&gt;<br>

		</td>
		<td colspan="2" align="left" valign="top" style="color:#5C6F9A;padding:20px;border-top:dotted 1px #AAAAAA;font-size:12px;">
			<br>
			&bull; ��һ��href="/blog/200018532.aspx ���ɶ�Ӧ���µĲ���id<br>
			&bull; �ڶ���id="comp_icon_c" ���ɶ�Ӧ��ͼ�ꡣ<img src="/Html/images/comp_icon_c.png" />comp_icon_c<img src="/Html/images/comp_icon_h.png" />comp_icon_h<img src="/Html/images/comp_icon_m.png" />comp_icon_m<img src="/Html/images/comp_icon_r.png" />comp_icon_r<img src="/Html/images/comp_icon_t.png" />comp_icon_t<img src="/Html/images/comp_icon_v.png" />comp_icon_v<br>
            &bull; ������2014�������Ѹ�ǧ����������֪�к������� ���ɶ�Ӧ�����µ����ơ�<br>
            &bull; ���ģ�����ʱ�䣺2014-11-15" ���ɶ�Ӧ�����±���ʱ�䡣<br>
            &bull; ���壺href="/Channels/Competetion/RaceProject.aspx?idcompete=300000508" ���ɶ�Ӧ������id��<br>
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
			    #preview {
			        width: 330px;
			        height: 340px;
			        padding-top: 5px;
			        text-align: left;
			        overflow: auto;
			    }

			    .zhuanti {
			        margin-bottom: -1px;
			        padding-top: 2px;
			        font-family: ΢���ź�,����;
			        padding-left: 0px;
			    }

			        .zhuanti li {
			            border-bottom: 1px dashed #dddddd;
			            line-height: 24px;
			            padding: 5px 0;
			        }

			            .zhuanti li a {
			                font-size: 15px;
			            }

			            .zhuanti li .zttitle {
			                font-size: 15px;
			                color: #438dc3;
			                font-weight: bold;
			            }
			</style>
			<div style="border:dotted 1px #EEEEFF;">
			<div id="preview">
                <ul id="slider" class="event">
                </ul>
			</div>
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
        $("#slider").html($("#cContent")[0].value);
    }

    function Finish() {
        if ($("#slider")[0].innerHTML.length < 1) {
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
