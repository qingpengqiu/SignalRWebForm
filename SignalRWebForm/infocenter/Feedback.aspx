<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Feedback.aspx.cs" Inherits="infocenter_Feedback" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ִ����-������-ERUN360.COM</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="���ִ����,�Ϳ�,���˾Ͷ�,����ָ��,�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
<link rel="stylesheet" type="text/css" href="/Html/css/base.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/themes.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<style>
	body{background: #b50000;position: relative; }
/*mini header css star*/
.header{height: 50px;background:  #fff ;background:hsla(0,0%,95%,0.9) ;width: 100%;position: relative;z-index: 10;position: fixed;}
.header{padding: 0}
.nav{float: left;width: 94px;height: 30px;background: #fff;border: 1px solid #dddddd;font-size: 12px;color: #888;line-height: 30px;text-align: center;margin:10px 0 0 10px;padding: 0;display: block;overflow: hidden;}
.nav li{float: none;line-height: 30px;height: auto;background: #fff;padding: 0;font-size: 14px;width: 94px;position: inherit;display: block;}
.nav img{display: none}
.nav dl{display: inline-block;padding: 0;position: relative;border: 0;width: 100%;z-index: 1;top: 0;left: 0}
.nav:hover{cursor: pointer;overflow: visible;}
.nav:hover ul{display: block;}
.nav ul{display: none;border: 1px solid #dddddd;width: 94px;margin-left: -1px;background: #fff}
.nav a{color: #888;display: inherit;}
.nav ul li:hover{background: #f3f3f3}
.nav ul li:hover a{color: #ff6600;}
.nav ul a{color: #888}
.nav li em{display: none}
.nav li a{color: #999}
.nav dl dt{line-height: 30px;height: auto;padding: 0;width: 100%;display: inline-block;}
.nav li a i{display: none}
.nav dl a{font-size: 14px;}
.nav li:last-child{background: #fff}
.nav li:first-child em{display: block;color: #999;height: auto;}
/*mini header css end*/
.feedback1{background: url(/Html/images/feedback1.jpg) no-repeat center top;width: 100%;height: 200px;width: 1375px;position: absolute;left: 50%;margin-left: -688px;top: 50px;}
.feedback2{background: url(/Html/images/feedback2.jpg) no-repeat center top;width: 100%;height: 200px;width: 1375px;position: absolute;left: 50%;margin-left: -688px;top: 250px;}
.feedback3{background: url(/Html/images/feedback3.jpg) no-repeat center top;width: 100%;height: 200px;width: 1375px;position: absolute;left: 50%;margin-left: -688px;top: 450px;}
.feedback4{background: url(/Html/images/feedback4.jpg) no-repeat center top;width: 100%;height: 200px;width: 1375px;position: absolute;left: 50%;margin-left: -688px;top: 650px;}
.feedback{width: 580px;margin: 42px 0 0 358px;color: #fffbe5;line-height: 36px;font-size: 16px;overflow: hidden;}
.feedback span,.feedback a{display: inline-block;background: #d6000d;padding: 0 8px; color: #fff}
.goback{width: 172px;height: 100px;display: block;margin: 86px 0 0 302px;background: none;border: 0;cursor: pointer;}
.mnav{display: none;}
.footer{color: #fff;border-top: 0}
.footer a{color: #fff}
</style>
<script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/Html/js/modernizr.js"></script>
<script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
 <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<body>
<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
     <form id="form1" runat="server">
    <div class="feedback1"></div>
    <div class="feedback2">
        <%--<a href="" class="goback"></a>--%>
        <asp:Button ID="btnGetValue" runat="server" Text="" CssClass="goback" OnClick="btnGetValue_Click" />
    </div>
    <div class="feedback3">
    	<div class="feedback">
    	
    	�����µĻ���ϵͳ����6��3�����ߣ����ǶԻ������˴����ĵ��������Ƴ��������������� <a href="/blog/200016255.aspx" target="_blank">ʹ�ù���</a>��Ϊ�˻����������ġ������ߡ������Ƴ��˴λ��ִ�������ͻ���������ߡ��ǿ�����ȡ��!
    	</div>
    </div>
         </form>
    <div class="feedback4"><ERUN360:Erun_Footer runat="server" ID="Erun_Footer" /></div>

<!-- Baidu Button BEGIN -->
    <script type="text/javascript" id="bdshare_js" data="type=slide&amp;img=5&amp;pos=right&amp;uid=6500883" ></script>
    <script type="text/javascript" id="bdshell_js"></script>
    <script type="text/javascript">
        document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date() / 3600000);
    </script>
<!-- Baidu Button END -->

</body>
</html>
