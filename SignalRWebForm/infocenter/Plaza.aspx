<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Plaza.aspx.cs" Inherits="infocenter_Plaza" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title>���߹㳡-������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <script type="text/javascript" src="/Common/jQuery1.8.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="../Html/js/jquery.emotions.js"></script>
    <style type="text/css">
        .nav li.h_gc em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
    </style>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
    	<div class="plazal">
    		<div class="npblog">
    			<div class="pltit">
    				���²���
    			</div>
    			<ul class="plazall">
                    <%=strBolg %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>������Sean :</span> </a>
    					<a href="">���������С�һ���������˶�Ա��һλ�������˵Ĳ�������</a>
    				</li>--%>
    			</ul>
    		</div>
    		<div class="nppl">
    			<div class="pltit">
    				��������
    			</div>
    			<ul class="plazall">
                     <%=strDiscuss %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>������Sean </span> </a>������:
    					<a href="">���������С�һ���������˶�Ա��һλ�������˵Ĳ�������</a>
    				</li>--%>
    			</ul>
    		</div>
    		<div class="nprun">
    			<div class="pltit">
    				��������
    			</div>
    			<ul class="plazall">
                     <%=strAmount %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>������Sean :</span> </a>���� <span>5KM</span> <br>
    					�ص㣺����ƥ��ɭ�ֹ�԰
    				</li>--%>
    			</ul>
    		</div>
    		<div class="npyp">
    			<div class="pltit">
    				����Լ��
    			</div>
    			<ul class="plazall">
                     <%=strRace %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>������Sean :</span> </a>12��5�� 9:00 
    					<a href="">��ɭ��԰ LSD 20KMԼ��</a>
    				</li>--%>
    			</ul>
    		</div>
    	</div>
    	<div class="plazar">
    		<div class="prtit">
    			���Ǹոռ�������
    		</div>
    		<ul class="pljion">
                <%=strUser %>
    			<%--<li><a href=""><img src="/Html/images/cAvatar.png" alt="">������Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">������Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">������Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">������Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">������Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">������Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">������Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">������Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">������Sean</a></li>--%>
    		</ul>
    		<div class="prtit">
    			�Ƽ�����
    		</div>
    		<ul class="plazall">
                <%=strIssue %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>������Sean :</span> </a>
    					<a href="">���������С�һ���������˶�Ա��һλ�������˵Ĳ�������</a>
    				</li>
    				<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>������Sean :</span> </a>
    					<a href="">���������С�һ���������˶�Ա��һλ�������˵Ĳ�������</a>
    				</li>--%>
    			</ul>
    	</div>
    </div>
    <script>
$('.nppl').emotions();
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>