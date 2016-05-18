<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Invitation.aspx.cs" Inherits="Member_Invitation" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ִ����-������-ERUN360.COM</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="���ִ����,�Ϳ�,���˾Ͷ�,����ָ��,�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
<link rel="stylesheet" type="text/css" href="/Html/css/base.css" />
<style>
	body{background: url(/Html/images/Invitation.jpg) no-repeat center 50px;position: relative; }
.nav{display: none}

footer{width: 960px;text-align: center;clear: both;margin: 0 auto;line-height: 24px;color: #3e3e3e;padding: 30px 0 20px}
footer a{color: #3e3e3e}

header{height: 50px;background-color: hsla(0,0%,95%,0.9) ; *+background:#fff;width: 100%;position: relative;z-index: 10;position: fixed;top: 0;left: 0}
article{width: 970px;margin: 0 auto}
nav{float: left;width: 94px;height: 30px;background: #fff;border: 1px solid #dddddd;font-size: 12px;color: #888;line-height: 30px;text-align: center;margin:10px 0 0 10px}
nav:hover{cursor: pointer;}
nav:hover ul{display: block;}
img[alt=erunlogo]{float: left;margin-top: -5px;}
nav ul{display: none;border: 1px solid #dddddd;width: 94px;margin-left: -1px;background: #fff}
nav a{color: #888;display: inherit;}
nav li{line-height: 30px;}
nav ul li:hover{background: #f3f3f3}
nav ul li:hover a{color: #ff6600;}
nav ul a{color: #888}
a:focus { outline: none; } 
.username1, .username2 { color: #333333; float: right; line-height: 50px; margin-right: 15px;}
.username{float: left;font-size: 14px;color: #900;font-weight: bold;line-height: 50px;text-align: right;width: 450px;padding-right: 6px;font-weight: bold;position: relative;}
.username:hover{color: #900}
.username a{font-weight: 100;color: #333;margin-right: -70px;position: absolute;zoom:1;z-index: 1000 ;}
.username1{right: -106px;}
.username2{right: -70px;}
.topr{height: 30px;border: 1px solid #dddddd;line-height: 30px;text-align: center;float: left;margin: 10px 0 0 6px;position: relative;-moz-box-shadow:2px 2px 0 #E6E6E6;-webkit-box-shadow:2px 2px 0 #E6E6E6;box-shadow:2px 2px 0 #E6E6E6;}
.topr a{color: #999;display: inline-block;}
.topr a:hover{color: #ff6600}
.topr span{color: #999;display: block;padding: 0 18px 0 14px;background: url(../images/jtx.png) no-repeat right 12px #F8F8F8;height: 100%;position: relative;z-index: 10;}
.topr span:hover{background: url(../images/jtx2.png) no-repeat right 12px #F8F8F8; }
.topr ul{width: 326px; border: 1px solid #ddd;position: absolute;top: 34px;right: -1px;background: #F8F8F8;-moz-box-shadow:2px 2px 0 #E6E6E6;-webkit-box-shadow:2px 2px 0 #E6E6E6;box-shadow:2px 2px 0 #E6E6E6;padding: 13px 0 0 0;display: none;}
.topr ul img{padding: 2px; border: 1px solid #ddd;display: block;}
.topr:hover{cursor: pointer;color: #990000;height: 36px;border-bottom: 0;-moz-box-shadow:2px 2px 0 #E6E6E6;-webkit-box-shadow:2px 2px 0 #E6E6E6;
	box-shadow:2px 0px 0 #E6E6E6;}
.toprb{cursor: pointer;color: #990000;height: 36px;border-bottom: 0;-moz-box-shadow:2px 2px 0 #E6E6E6;-webkit-box-shadow:2px 2px 0 #E6E6E6;
	box-shadow:2px 0px 0 #E6E6E6;}
.toprb span{background: url(../images/jtx2.png) no-repeat right 12px #F8F8F8;color: #990000 }
.toprb ul{display: block;}

.topr:hover ul{display: block;}	
.topr:hover span{color: #990000}
.topr ul li{float: left;margin-left: 20px;width: 82px;line-height: 30px;}
.vertical ul{width: 100%;padding-top: 0;top: 29px;}
.vertical ul li{margin: 0;text-align: left;padding-left: 14px;}
.imgcach{width: 1px;height: 1px;overflow: hidden;}
.msgshowa,.msgshowl,.msgshowb,.msgshowf,.msgshowpl{position: relative;}
.msgshowa em,.msgshowl em,.msgshowb em,.msgshowf em,.msgshowpl em{position: absolute;display: inline-block;background: #fb9100;width: 16px;height: 16px;border-radius: 8px;top:-4px;line-height: 16px;color: #fff;text-align: center;font-size: 10px;}
.mnav{display: none;}
.Invitation{padding-top: 144px;width: 530px;margin: 0 auto;padding-left: 440px;padding-bottom: 130px;}
.Invitation h1{color: #c70909;font-size: 64px;padding-bottom: 38px;line-height: 64px;}
.Invitation h2{font-size: 22px;color: #3e3e3e;line-height: 38px;padding-bottom: 27px;}
.Invitation i{font-style: normal;color: #f97b0c}
.cpurl{color: #428ccb;font-size: 14px;}
.fuzhi,.fenxiang{display: inline-block;border-radius: 3px;
  background-image: -moz-linear-gradient( 90deg, rgb(232,232,232) 0%, rgb(232,232,232) 18%, rgb(236,236,236) 18%, rgb(253,253,253) 100%);
  background-image: -webkit-linear-gradient( 90deg, rgb(232,232,232) 0%, rgb(232,232,232) 18%, rgb(236,236,236) 18%, rgb(253,253,253) 100%);
  background-image: -ms-linear-gradient( 90deg, rgb(232,232,232) 0%, rgb(232,232,232) 18%, rgb(236,236,236) 18%, rgb(253,253,253) 100%);color: #478b00;padding: 3px 13px;border: 1px solid #d5d5d5
 }
 .Invitation p{color: #999999;padding-top: 6px;}
</style>
<script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/Html/js/modernizr.js"></script>
<script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
<div class="Invitation">
	<h1>����ע���ͻ��֣�</h1>
	<h2>�������ע��������ÿ�˴ο��Եõ�<i>300</i>���֣� <br>�����Ի��<i>3000</i>����!</h2>
	<a class="cpurl" href="javascript:void(0)" id="copyUrl2"><%=url %></a>
	<a class="fuzhi" href="javascript:void(0)" id="copyUrl">����</a>
	
	<p>�����ӷ������ѵ��ע�ἴ��</p>
</div>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
<script type="text/javascript">
$('#copyUrl').zclip({
        path:'/Html/js/ZeroClipboard.swf',
        copy: '<%=url %>'
    });
$('#copyUrl2').zclip({
        path:'/Html/js/ZeroClipboard.swf',
        copy: '<%=url %>'
    });
</script>
<!-- Baidu Button BEGIN -->
    <script type="text/javascript" id="bdshare_js" data="type=slide&amp;img=5&amp;pos=right&amp;uid=6500883" ></script>
    <script type="text/javascript" id="bdshell_js"></script>
    <script type="text/javascript">
        document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date() / 3600000);
    </script>
<!-- Baidu Button END -->
</form>
</body>
</html>
