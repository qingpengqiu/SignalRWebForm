<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchClub.aspx.cs" Inherits="infocenter_SearchClub" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>�������ֲ�-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Common/jWeibo.js"></script>
    <script  type="text/javascript" src="../Html/js/jquery.blockUI.js"></script>
    <style type="text/css">
       .scleft{width: 725px;float: left;}
       .scright{width: 230px;float: right;border: 1px solid #e4e4e4;margin-bottom: 20px;}
       .slbox{border: 1px solid #ffe8c3;background: #fffaf3;height: 53px;font-size: 14px;color: #333;padding: 24px 0 0 0 }
       #idCity,#cCityname{display: none;}
       .slbox label{display: inline-block;margin-left: 20px;margin-right: 4px;}
       .slbox #keyclub{width: 122px;margin-bottom: 6px;}
       .slbox select{width: 98px;margin-bottom: 6px;}
       .sltitle{line-height: 47px;height: 47px;margin-top: 10px;font-size: 16px;color: #ff7800;font-weight: bold;background: url(/Html/images/oright.png) no-repeat 10px 16px  #f5f5f5;}
       .clubox li{width: 329px;height: 133px;float: left;border: 1px solid #e4e4e4;margin:9px 14px 8px 0; padding: 12px;font-size: 12px;color: #666;line-height: 24px;}
       .clubox li:nth-child(even){margin-right: 0;}
       .clubox li img{width: 50px;border: 1px solid #cecece;float: left;margin-right: 15px;}
       .clubox li a{font-size: 15px;color: #2874c1;font-weight: bold;line-height: 26px;}
       .clubox li p{line-height: 21px;padding-top: 10px;}
       .scrightt{height: 34px;background: #d9e3e7;margin: 0 -1px;font-size: 14px;color: #2874c1;font-weight: bold;line-height: 36px;}
       .scrul {padding: 0 11px;overflow: hidden;}
       .scrul li{border-bottom: 1px dotted #b3ccc0;overflow: hidden;padding: 20px 0 15px 0}
       .scrul li:last-child{border: 0;}
       .scrul img{width: 50px;float: left;margin-right: 8px;}
       .scrul p{font-size: 12px;color: #333;width: 150px;line-height: 21px;float: right;}
       .scrul p a{display: block;color: #2874c1;line-height: 23px;}
       .sctul {padding: 10px 0}
       .sctul li{background: url(/Html/images/hdd.png) no-repeat 13px center;padding-left: 24px;font-size: 12px;line-height: 30px;}
       .nav li.h_jlb em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
    </style>
    <script language="javascript" src="/Common/jCheck.js"></script>
        <script language="javascript" src="/Common/jPopup.js"></script>
        <script language="javascript" src="/Common/jCalendar.js"></script>
        <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
        <script language="javascript" src="/Common/jquery.colorbox.js"></script>
        <script type="text/javascript" src="../Common/jCity.js"></script>     
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
        <div class="indecen">
            <div class="scleft">
            	<div class="slbox">
            		<form action="">
            			<label for="">�ؼ��֣�</label><input type="text" id="keyclub" runat="server"><label for="">����</label><select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)"></select>
                            <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)"></select>
                            <script type="text/javascript">
                                BindProvince("����");
                            </script>
                             <input type="text" id="idCity" name="idCity" size="5" readonly value="0"  runat="server"/>
                             <input type="text" id="cCityname" name="cCityname" size="15" readonly value=""  runat="server"/>
                            <input name="UpdatedFields" type="hidden" id="UpdatedFields" />
                            <label for="">����</label>
                            <select id="idStyle" runat="server">
                            	<option value="0">��ѡ��</option>
                                <option value="1">�ܲ�</option>
                                <option value="2">�ﳵ</option>
                                <option value="3">ԽҰ</option>
                                <option value="4">ͽ��</option>
                            </select>
                            <asp:ImageButton ID="IBtnSearch" runat="server" ImageUrl="/Html/images/serb71.png" OnClick="IBtnSearch_Click" />
            		</form>
            	</div>
            	<div class="sltitle">
            		 &nbsp;&nbsp;&nbsp;&nbsp;�������
            	</div>
            	<ul class="clubox">
                      <%=mJion %>
            		<%--<li>
            			<a href=""><img src="/Html/images/rentou.png" alt=""></a><a href="">�Ҽ���ľ��ֲ� </a><br>
            			���£�33 | ͼƬ��453 | ���2 | ��Ա��88
            			<p>�Ҽ���ľ��ֲ��Ҽ���ľ��ֲ��Ҽ���ľ��ֲ��Ҽ���ľ��ֲ��Ҽ���ľ��ֲ�</p>
            		</li>
            		<li></li>--%>
            	</ul>
                <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                                    NextPageText="��һҳ" CssClass="pages"
                                    CurrentPageButtonClass="cpb" PrevPageText="��һҳ"
                                    OnPageChanged="pager_PageChanged" PageSize="10">
                                </webdiyer:AspNetPager>
            </div>
            <div class="scright">
            	<div class="scrightt">&nbsp;&nbsp;���ž��ֲ�</div>
            	<ul class="scrul">
                     <%=hot %>
            		<%--<li><a href=""><img src="/Html/images/rentou.png" alt=""></a>
						<p><a href="">�⻪����ѧԺ--�����ս</a>����Ϊ���̽�ĳɹ���ʿ�����������ж�ǿ��</p>
            		</li>
            		<li><a href=""><img src="/Html/images/rentou.png" alt=""></a>
						<p><a href="">�⻪����ѧԺ--�����ս</a>����Ϊ���̽�ĳɹ���ʿ�����������ж�ǿ��</p>
            		</li>
            		<li><a href=""><img src="/Html/images/rentou.png" alt=""></a>
						<p><a href="">�⻪����ѧԺ--�����ս</a>����Ϊ���̽�ĳɹ���ʿ�����������ж�ǿ��</p>
            		</li>--%>
            	</ul>
            	<div class="scrightt">&nbsp;&nbsp;��������</div>
            	<ul class="sctul">
                     <%=hotBlog %>
            		<%--<li><a href="">�׽�����ɽ����ԽҰ������11��</a></li>
            		<li><a href="">�׽�����ɽ����ԽҰ������11��</a></li>
            		<li><a href="">�׽�����ɽ����ԽҰ������11��</a></li>
            		<li><a href="">�׽�����ɽ����ԽҰ������11��</a></li>--%>
            	</ul>
            	<div class="scrightt">&nbsp;&nbsp;��������</div>
            	<ul class="sctul">
                     <%=NewBlog %>
            		<%--<li><a href="">�׽�����ɽ����ԽҰ������11��</a></li>
            		<li><a href="">�׽�����ɽ����ԽҰ������11��</a></li>
            		<li><a href="">�׽�����ɽ����ԽҰ������11��</a></li>
            		<li><a href="">�׽�����ɽ����ԽҰ������11��</a></li>--%>
            	</ul>
            </div>
        </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    </form>
</body>
</html>
