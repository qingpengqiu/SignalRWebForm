<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payoffwx.aspx.cs" Inherits="Competetion_payoffwx" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
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
            <h4><asp:Literal ID="ltlItem" runat="server"></asp:Literal></h4><br>
            请您及时付款，以便订单尽快处理！ 订单号：<%=OrderNo %> <br>
			请您在提交订单后<em><b><asp:Literal ID="ltlMax" runat="server"></asp:Literal></b></em>内完成支付，否则订单会自动取消。 <br>
            应付金额 ：￥<i><asp:Literal ID="ltlCost" runat="server"></asp:Literal></i><div class="zfzt"></div>
       </div> 
       <style type="text/css">
       .racepay{width: 770px;padding: 0 34px}
        .racepay em {color:red; }
       	.rcode{width: 300px;height: 360px;border: 1px solid #dddddd;border-bottom: 60px solid #f5b133}
       	.rcode img{width: 100%;}
        .weixin{background: url(/Html/images/wxsm.png) no-repeat 400px top;border-top: 1px dashed #d9e5df;width: 770px;margin: 16px auto;padding: 36px 34px}
         .zfzt { color:red;}
@media screen and (min-width:100px) and (max-width:800px) {
        .weixin{width: 100%;padding: 420px 0 0 0;border: 0;background-position: center top;margin: 0}
        .rcode{margin: 0 auto;}

}
       </style>
       <div class="weixin"> 
       		<div class="rcode">
                  <%-- <img src="http://www.xueshenghui.cn/static/default/hd/images/code.png">--%>
                    <img src="/Competetion/payment/QRcode.aspx?parm=<%= parm %>" id="vimg" alt="" />
            <%--<input type="button" value="换一张" onclick="change()" />--%>
       		</div>
       </div>
      </div>
    </div>
  </div>
</div>
    <script type="text/javascript">   
     //   function change() {
     //       var imgNode = document.getElementById("vimg");
     //       imgNode.src = "/Competetion/payment/QRcode.aspx?t=" + <%= parm %>;
     //   }

        //var int=self.setInterval("gettwo()",3000)
        jQuery(document).ready(function($) {
            //gettwo()
            timedCountpay()
        });
        var t;
        function timedCountpay() {
            t = self.setInterval("getpay()", 2000);
        }
        function stopCountpay() {
            timedCountpay(t);
        }
        function getpay() {
            $.ajax({
                type: "GET",
                url: "/action/EventService.ashx",
                 
                data: { op:"wxpay",sid:"<%=sid%>",id:"<%=id%>",p:"<%=idItem%>",rnd: Math.random() },
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (data) {
                         //console.log(data.status)
                         if(data.status=="-1"){                            
                             $(".zfzt").html(data.msg);                          
                             stopCountpay();
                         } else if (data.status == "0") {
                             stopCountpay();
                             PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                         } else if (data.status == "1") {       
                             $(".zfzt").html(data.msg);
                             $(".zfzt").attr("color", "green");
                             window.setTimeout(function(){ location.href = '/Competetion/OrderDetails.aspx?sid=<%=sid%>&nav=2&orderid=' + data.orderid; },3000);
                             //window.location.href = '/Competetion/OrderDetails.aspx?sid=<%=sid%>&nav=2&orderid=' + data.orderid;
                     } else { }
                 }
                 }); 
        }
    </script>
   <form id="from2" runat="server">
        </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />
