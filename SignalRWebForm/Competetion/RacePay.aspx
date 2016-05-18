<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RacePay.aspx.cs" Inherits="Channels_Competetion_RacePay" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<%@ Register Src="~/Competetion/headerv2.ascx" TagPrefix="ERUN360" TagName="headerv2" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %><!DOCTYPE html>
<html lang="cn">
<head>
  <meta charset="gb2312">
  <title>Marathon</title>
  <link rel="stylesheet" href="/mz/css/amazeui.min.css">
  <link rel="stylesheet" href="/Html/css/marathon.css">
  <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />

  <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
  <script src="/Html/js/jquery-1.11.1.min.js"></script>
  <script src="/Html/js/marathon.js"></script>
  <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
  <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
  <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
  <script type="text/javascript" src="/Common/jCalendar.js"></script>


    <script type="text/javascript" src="/Common/jCity.js"></script>
</head>
<body>
  <ERUN360:headerv2 runat="server" ID="headerv2" />
  <div class="banner">
    <div class="mine"><h1>��������</h1>
      <img src="/Html/images/banner.jpg" alt="">
    </div>
  </div>
  <div class="tbody">
    <div class="mine">
      <ERUN360:bmnav runat="server" ID="bmnav" />
      <div class="tbodyBox">
        <div class="event this clearfix">
    <form id="form1" runat="server">
       <div class="racepay">
            <h3>��ѡ���Ĳ�Ʒ��</h3>
            <h4>2015Ⱥ�ɱ������ݹ���ԽҰ��ս��</h4>
            ��Ŀ����������� <br>
            �۸񣺣�<i>160</i>
            <a class="fkbuttom" href="">��������</a>
       </div> 
       <div class="othercp">
            <div class="othertitle">ѡ��������Ʒ��</div>
            <div class="otherlist minijd">
                <a class="gobuy">���빺�ﳵ</a>
                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (�¼��±��������žƵ�) ˫����</a>
                �Ƶ�۸񣺣�<i>160</i>
                <div class="hotelthumb">
                    <img src="/html/images/Feet4.png">
                </div>
                <a class="othermore">�鿴ȫ��>></a>
            </div>
            <div class="otherlist minijt">
                <a class="flynu">
                    ��� �� ����<br>
                    ��<em>160</em>
                </a><a class="flynu">
                    ��� �� ����<br>
                    ��<em>160</em>
                </a><a class="flynu">
                    ��� �� ����<br>   
                    ��<em>160</em>
                </a><a class="flynu">
                    ��� �� ����<br>
                    ��<em>160</em>
                </a><br>
                <a class="othermore">�鿴ȫ��>></a>
            </div>
            <div class="otherlist minily">
                <a class="gobuy">���빺�ﳵ</a>
                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (�¼��±��������žƵ�) ˫����</a>
                �Ƶ�۸񣺣�<i>160</i>
                <div class="hotelthumb">
                    <img src="/html/images/Feet4.png">
                </div>
                <a class="othermore">�鿴ȫ��>></a>
            </div>
            <div class="otherlist minizb">
                <a class="gobuy">���빺�ﳵ</a>
                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (�¼��±��������žƵ�) ˫����</a>
                �Ƶ�۸񣺣�<i>160</i>
                <div class="hotelthumb">
                    <img src="/html/images/Feet4.png">
                </div>
                <a class="othermore">�鿴ȫ��>></a>
            </div>
            <div class="otherlist miniqz">
                <a class="gobuy">���빺�ﳵ</a>
                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (�¼��±��������žƵ�) ˫����</a>
                �Ƶ�۸񣺣�<i>160</i>
                <div class="hotelthumb">
                    <img src="/html/images/Feet4.png">
                </div>
                <a class="othermore">�鿴ȫ��>></a>
            </div>

       </div>
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




                   
    </form>
        </div>
      </div>
    </div>
  </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>











        