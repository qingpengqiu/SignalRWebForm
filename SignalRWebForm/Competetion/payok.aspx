<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payok.aspx.cs" Inherits="Competetion_payok" %>
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
           <br>
            价格：￥<i><asp:Literal ID="ltlCost" runat="server"></asp:Literal></i>
           <br>          
           <br>
           <asp:Literal ID="ltlresult" runat="server"></asp:Literal>
          <%--  失败原因：失败原因失败原因失败原因失败原因失败原因失败原因失败原因失败原因
           <a class="fkbuttom" >付款成功</a>--%>
       </div> 
       <style type="text/css">
       .zhifu{text-align: center;padding: 30px 0;}
       .zhifu .weixin{margin: 10px;}
       .racepay em {color:red; }
       </style>
       <div class="zhifu"> 

       </div>
      </div>
    </div>
  </div>
</div>
    </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />