<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payoff.aspx.cs" Inherits="Competetion_payoff" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
    <form id="form1" runat="server">
  <div class="banner">
    <div class="mine"><h1><%=title %></h1>
     <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
    </div>
  </div>
  <div class="tbody">
    <div class="mine">
      <ERUN360:bmnav runat="server" ID="bmnav" />
      <div class="tbodyBox">
        <div class="event this clearfix">
       <div class="racepay">
            <h3>您选订的产品：</h3>
            <h4><asp:Literal ID="ltlItem" runat="server"></asp:Literal> </h4>
            请您及时付款，以便订单尽快处理！ 订单号：<%=OrderNo %> <br>
			请您在提交订单后<em><b><asp:Literal ID="ltlMax" runat="server"></asp:Literal></b></em>内完成支付，否则订单会自动取消。 <br>
            价格：￥<i><asp:Literal ID="ltlCost" runat="server"></asp:Literal></i>
       </div> 
       <style type="text/css">
       .zhifu{text-align: center;padding: 30px 0;}
       .zhifu .weixin{margin: 10px;}
       .racepay em { color: #ccc;padding: 0 6px;}
       .racepay b {color:red;font-weight: 100}
       .racepay h4 em:last-child{display: none;}
       </style>
       <div class="zhifu"> 
           <asp:ImageButton ID="wxpay" runat="server" CssClass="weixin" ImageUrl="~/Html/images/wx.png" OnClick="wxpay_Click" />
           <asp:ImageButton ID="wapwxpay" runat="server" CssClass="weixin" ImageUrl="~/Html/images/wx.png" OnClick="wapwxpay_Click" />
           <asp:ImageButton ID="Alipay" runat="server" ImageUrl="~/Html/images/alipay.png" CssClass="alipay" OnClick="Alipay_Click" />
           <asp:ImageButton ID="wapAlipay" runat="server" ImageUrl="~/Html/images/alipay.png" CssClass="alipay" OnClick="wapAlipay_Click" />
           
           <%--<a class="weixin" href="payoffwx.aspx"><img src="/Html/images/wx.png"></a>
           <a class="alipay"><img src="/Html/images/alipay.png"></a>--%>

       </div>
      </div>
    </div>
  </div>
</div>
    </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />