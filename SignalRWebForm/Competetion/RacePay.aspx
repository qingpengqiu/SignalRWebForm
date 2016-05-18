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
    <div class="mine"><h1>比赛名称</h1>
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
            <h3>您选订的产品：</h3>
            <h4>2015群飞杯·婺州国际越野挑战赛</h4>
            项目：半程马拉松 <br>
            价格：￥<i>160</i>
            <a class="fkbuttom" href="">立即付款</a>
       </div> 
       <div class="othercp">
            <div class="othertitle">选购其它产品：</div>
            <div class="otherlist minijd">
                <a class="gobuy">加入购物车</a>
                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a>
                酒店价格：￥<i>160</i>
                <div class="hotelthumb">
                    <img src="/html/images/Feet4.png">
                </div>
                <a class="othermore">查看全部>></a>
            </div>
            <div class="otherlist minijt">
                <a class="flynu">
                    天津 → 北京<br>
                    ￥<em>160</em>
                </a><a class="flynu">
                    天津 → 北京<br>
                    ￥<em>160</em>
                </a><a class="flynu">
                    天津 → 北京<br>   
                    ￥<em>160</em>
                </a><a class="flynu">
                    天津 → 北京<br>
                    ￥<em>160</em>
                </a><br>
                <a class="othermore">查看全部>></a>
            </div>
            <div class="otherlist minily">
                <a class="gobuy">加入购物车</a>
                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a>
                酒店价格：￥<i>160</i>
                <div class="hotelthumb">
                    <img src="/html/images/Feet4.png">
                </div>
                <a class="othermore">查看全部>></a>
            </div>
            <div class="otherlist minizb">
                <a class="gobuy">加入购物车</a>
                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a>
                酒店价格：￥<i>160</i>
                <div class="hotelthumb">
                    <img src="/html/images/Feet4.png">
                </div>
                <a class="othermore">查看全部>></a>
            </div>
            <div class="otherlist miniqz">
                <a class="gobuy">加入购物车</a>
                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a>
                酒店价格：￥<i>160</i>
                <div class="hotelthumb">
                    <img src="/html/images/Feet4.png">
                </div>
                <a class="othermore">查看全部>></a>
            </div>

       </div>
<div class="indecen">
            <div class="racebody racetimew">
            <h1><asp:Label ID="LabelTitle2" runat="server" Text="参赛项目"></asp:Label></h1>
            <div class="payrace">
                <div class="payracetr">
                    <div class="payracetd">
                        <em>参赛项目</em>
                    </div>
                    <div class="payracetd">
                        <asp:Label ID="LabelTitle" runat="server" Text="参赛项目"></asp:Label>
                    </div>
                </div>
                <div class="payracetr">
                    <div class="payracetd">
                        <em>订购内容</em>
                    </div>
                    <div class="payracetd">
                        <asp:Label ID="Labeltype" runat="server" Text="订购内容"></asp:Label>
                    </div>
                </div>
                <div class="payracetr">
                    <div class="payracetd">
                        <em>总金额</em>
                    </div>
                    <div class="payracetd payrmb">
                        人民币:￥<asp:Label ID="Labelcost" runat="server" Text="总金额"></asp:Label>元
                    </div>
                </div>
                <div class="payracetr">
                    <div class="payracetd">
                        <em>在线支付</em>
                    </div>
                    <div class="payracetd paynum">
                        <%if (idAlipay != "")
                          {%><span>已完成支付</span>
                        <% } %>
                        <%else
                          {%><asp:Button ID="Buttonpay" Text="使用支付宝在线支付" runat="server" value="Button" OnClick="Button1_Click" Enabled="False" /><asp:Button ID="BtnAlipay" name="BtnAlipay" Text="立即支付" 
                                runat="server" OnClick="BtnAlipay_Click" Enabled="False" /><% } %>
                        订单号: <%=Request["orderid"].Trim()%> (请于2小时之内完成付款)
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











        