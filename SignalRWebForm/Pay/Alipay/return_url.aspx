<%@ Page Language="C#" AutoEventWireup="true" CodeFile="return_url.aspx.cs" Inherits="Pay_Alipay_return_url" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
</head>
<body>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jPopup.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>

    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
        <div class="indecen">
            <div class="racebody racetimew">
                <h1><%=cTitle%></h1>
                <div class="payrace">
                    <div class="payracetr">
                        <div class="payracetd">
                            <em>������Ŀ</em>
                        </div>
                        <div class="payracetd">
                            <%=cTitle%>
                        </div>
                    </div>
                    <div class="payracetr">
                        <div class="payracetd">
                            <em>��������</em>
                        </div>
                        <div class="payracetd">
                            <span><%=cType%></span>
                        </div>
                    </div>
                    <div class="payracetr">
                        <div class="payracetd">
                            <em>�ܽ��</em>
                        </div>
                        <div class="payracetd payrmb">
                            �����:�� <span><%=iCost%></span> Ԫ
                        </div>
                    </div>
                    <div class="payracetr">
                        <div class="payracetd">
                            <em>����֧��</em>
                        </div>
                        <div class="payracetd paynum">
                            <span>
                                <%=stringresult%></span>������: <%=Request["out_trade_no"].Trim()%>
                        </div>
                    </div>
                </div>
                <asp:Literal ID="ltlgoteam" runat="server"></asp:Literal>

            </div>
        </div>
    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
