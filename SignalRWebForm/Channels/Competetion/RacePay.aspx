<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RacePay.aspx.cs" Inherits="Channels_Competetion_RacePay" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
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
    <script type="text/javascript" src="/Common/jQuery1.8.js"></script>
    <link href="favicon.ico" rel="shortcut icon" type="image/ico"/>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/cansai-from.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/race.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jQuery1.8.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
        <div class="indecen">
            <div class="racebody racetimew">
            <h1><asp:Label ID="LabelTitle2" runat="server" Text="������Ŀ"></asp:Label></h1>
            <div class="payrace">
                <div class="payracetr">
                    <div class="payracetd">
                        <em>������Ŀ</em>
                    </div>
                    <div class="payracetd">
                        <asp:Label ID="LabelTitle" runat="server" Text="������Ŀ"></asp:Label>
                    </div>
                </div>
                <div class="payracetr">
                    <div class="payracetd">
                        <em>��������</em>
                    </div>
                    <div class="payracetd">
                        <asp:Label ID="Labeltype" runat="server" Text="��������"></asp:Label>
                    </div>
                </div>
                <div class="payracetr">
                    <div class="payracetd">
                        <em>�ܽ��</em>
                    </div>
                    <div class="payracetd payrmb">
                        �����:��<asp:Label ID="Labelcost" runat="server" Text="�ܽ��"></asp:Label>Ԫ
                    </div>
                </div>
                <div class="payracetr">
                    <div class="payracetd">
                        <em>����֧��</em>
                    </div>
                    <div class="payracetd paynum">
                        <%if (idAlipay != "")
                          {%><span>�����֧��</span>
                        <% } %>
                        <%else
                          {%><asp:Button ID="Buttonpay" Text="ʹ��֧��������֧��" runat="server" value="Button" OnClick="Button1_Click" Enabled="False" /><asp:Button ID="BtnAlipay" name="BtnAlipay" Text="����֧��" 
                                runat="server" OnClick="BtnAlipay_Click" Enabled="False" /><% } %>
                        ������: <%=Request["orderid"].Trim()%> (����2Сʱ֮����ɸ���)
                    </div>
                </div>
            </div>
               <%-- <asp:Literal ID="ltlgoteam" runat="server"></asp:Literal>--%>
        </div>
        </div>
    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
