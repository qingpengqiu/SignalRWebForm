<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceList.aspx.cs" Inherits="Channels_Competetion_RaceList" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<title>������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
<meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<meta property="wb:webmaster" content="a859eadcc5aee52a" />
<link href="favicon.ico" rel="shortcut icon" type="image/ico">
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<link href="/Common/cansai-from.css?2012111" rel="stylesheet" type="text/css"/>
<link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
<script language="javascript" src="/Common/jQuery1.8.js"></script>
<script language="javascript" src="/Common/bootstrap.min.js"></script>
</head>
<style>
.nav li.h_js em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
</style>
<body>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jPopup.js"></script>
<script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<style type="text/css">
.mlistnav .this<%=id%>{background: #e0af80;color: #fff;}
</style>
<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
    <div class="indecen">
        <div class="mlistnav">
            <a href="/Channels/Competetion/RaceList.aspx?id=1" class="this1">�������</a><a href="/Channels/Competetion/RaceList.aspx?id=2" class="this2">��������</a><a href="/Channels/Competetion/RaceList.aspx?id=3" class="this3">��������</a><a href="/Channels/Competetion/RaceList.aspx?id=4&Page=1" class="this4">�ѽ�������</a>
            <a href="/Channels/Competetion/internationalEvents.aspx" class="internationlink" target="_blank">�����ɹ�������ֱͨ��</a>
        </div>
	<div class="mlslist">
		<ul>
     <asp:Repeater ID="rptrunrecord" runat="server" OnItemDataBound="rptrunrecord_ItemDataBound">
                <ItemTemplate>
                    <li><span><a target="_blank" href="/blog/<%#Eval("idblog")%>.aspx"><%#Eval("cTitle")%></a></span>
				        <img src="<%#Eval("cURL").ToString()%> " width="148"/>
				        ����ʱ�䣺<%#Convert.ToDateTime(Eval("dRaceBegin")).ToString("yyyy-MM-dd")%> <br>
                        ������ֹʱ�䣺<%#Convert.ToDateTime(Eval("dJoinEnd")).ToString("yyyy-MM-dd")%> <br>
				        �������ã�<asp:Repeater runat="server" ID="rpquestionlist">
                            <ItemTemplate>
                                 <%#XString.ContentTrunc(Eval("text").ToString(), 100)%>                              
                            </ItemTemplate>
                        </asp:Repeater>				        
                         <%#DateTime.Compare(DateTime.Now,Convert.ToDateTime(Eval("dJoinEnd").ToString())) <= 0?"<a target='_blank' class='csbm' href='RaceProject.aspx?idcompete="+Eval("id")+"'>��������</a>":" <a class='jieshu'>��������</a>"%>
			        </li>
                </ItemTemplate>
            </asp:Repeater>
		</ul>
	</div>
   <div id="apage" runat="server" visible="false" class="pages">
   <asp:label ID="lblCurrentPage" runat="server"></asp:label>
   <asp:HyperLink id="lnkFrist" runat="server">��ҳ</asp:HyperLink>
   <asp:HyperLink id="lnkPrev" runat="server">��һҳ</asp:HyperLink>
   <asp:HyperLink id="lnkNext" runat="server">��һҳ</asp:HyperLink> 
   <asp:HyperLink id="lnkEnd" runat="server">βҳ</asp:HyperLink>
</div>

</div>

    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
