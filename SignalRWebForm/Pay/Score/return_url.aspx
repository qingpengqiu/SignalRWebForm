<%@ Page Language="C#" AutoEventWireup="true" CodeFile="return_url.aspx.cs" Inherits="Pay_Score_return_url" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />

    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <script language="javascript" src="/Common/jQuery1.8.js"></script>
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/cansai-from.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/race.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jCalendar.js"></script>
    <script language="javascript" src="/Common/jQuery1.8.js"></script>
    <script language="javascript" src="/Common/bootstrap.min.js"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
</head>
<body>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <style type="text/css">
        .buylc {
            height: 80px;
            line-height: 80px;
            font-size: 26px;
            color: #333;
            padding-left: 20px;
            padding-bottom: 22px;
        }

            .buylc span {
                color: #f40600;
            }

            .buylc .lc {
                background: url(/Html/images/ddlc.png) no-repeat left -250px;
                display: inline-block;
                height: 47px;
                width: 684px;
                margin: 0 0px -4px 10px;
            }
    </style>
    <form id="form1" runat="server">
        <div class="indecen">
            <div class="racebody racetimew">
                <div class="buylc">
                    �һ�<span>������</span>
                    <div class="lc"></div>
                </div>
                <h1><%=cTitle%></h1>
                <table class="payrace">
                    <tr>
                        <td><em>������Ʒ</em></td>
                        <td>
                            <span><%=cTitle%></span>
                        </td>
                    </tr>
                    <tr>
                        <td><em>�ܽ��</em></td>
                        <td class="payrmb">�����:�� <span><%=iCost%></span> Ԫ
                        </td>
                    </tr>
                    <tr>
                        <td><em>����֧��</em></td>
                        <td class="paynum">
                            <span>
                                <%=stringresult%></span>  ������: <%=Request["out_trade_no"].Trim()%>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
