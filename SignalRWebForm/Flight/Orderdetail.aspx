<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Orderdetail.aspx.cs" Inherits="Flight_Orderdetail" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/flight.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
</head>
<body>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jPopup.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>

    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="flithtpaysucc">
        <div class="article">
            <div class="qrnr" id="div2">
    <div class="hbbox successhbbox">
    <div class="successbox">
       <asp:Literal ID="ltlstatus" runat="server"></asp:Literal>
    </div>
    �����ţ�<asp:Literal ID="ltlorder" runat="server"></asp:Literal> <br>
    �������ڣ�<asp:Literal ID="ltltime" runat="server"></asp:Literal> <br>
    �ܽ�&yen;<i><asp:Literal ID="ltlcost" runat="server"></asp:Literal></i>
        Pnr��<asp:Literal ID="ltlpnr" runat="server"></asp:Literal> <br>
         OldPnr��<asp:Literal ID="ltloldPnr" runat="server"></asp:Literal> <br>
    </div>
    <div class="hbbox">
        <asp:Literal ID="ltlhk" runat="server"></asp:Literal>
      <%--<div class="fddt"><i>2015-04-05</i>�����׶� �� ����</div>
      <div class="fdxl"><i>���ʺ���CA4136</i><em>20:00</em>�����׶�T3<br><i>73T</i><em>23:00</em>����T2<img src="/Html/images/small/CA.gif"></div>--%>
    </div>
    <div class="hbbox">
      <div class="hbtitle">�˿���Ϣ</div>
        <asp:Literal ID="ltlck" runat="server"></asp:Literal>
     <%-- <div class="ckinfo"><i>�������Ź���</i><em>���֤��372922198303066293</em>�ֻ��ţ�13522968082<br></div>--%>
    </div>
    <div class="hbbox">
      <div class="hbtitle">������Ϣ</div>
        <asp:Literal ID="ltlbx" runat="server"></asp:Literal>
        <%--<div class="bxinfo">�����ˣ��Ź���&nbsp;&nbsp;</div>--%>
    </div>
    <div class="hbbox xcdbox">
    <div class="hbtitle"><asp:Literal ID="ltlxcd" runat="server"></asp:Literal>��ϵ����Ϣ</div>
        <asp:Literal ID="ltllxr" runat="server"></asp:Literal>     
      <%--<div class="xcdinfo">����������&nbsp;&nbsp;�ֻ����룺18511583497&nbsp;&nbsp;��ϵ��ַ����ַ&nbsp;&nbsp;��ע������</div>--%>
    </div>
    <div class="hbbox hbboxl">
        <div class="jginfo">��ʾ���֣����������������µ磺021-95500̫ƽ����24Сʱ�ͷ����ߣ����������������µ磺4007001951���¼ y.ebao51.cn��һ������£��������躽�չ�˾������������֤����̫ƽ���ս�������ϵͳ����Ϣ�������⣬�类�����˶�̫ƽ���չ�˾��ȡ֤��Ϣ�����飬�򰴱��������ṩ�ĺ��չ�˾���ߵ�����֤������������������ϴ�����������������ί�����˰����������˵ģ������ṩ��������ʵ���Ƶ����п��������յ��������������ݹ�˾Э������</div>
    </div>
    <div class="returnbox">
        <a class="returnfk dy" href="javascript:void(0)">��ӡ����</a>
        <a class="returnfk" href="/Flight/Flight_Search.aspx">��������</a>
    </div>
  </div>
        </div>
    </div>
    <span id="div1"></span>
    <script type="text/javascript">
        $(".dy").click(function (event) {
            document.body.innerHTML = document.getElementById('div1').innerHTML + '<br/>' + document.getElementById('div2').innerHTML;
            window.print();
        });
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
<%=outhtml%>
