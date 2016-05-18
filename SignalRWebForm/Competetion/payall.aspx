<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payall.aspx.cs" Inherits="Competetion_payall" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
    <div class="banner">
        <div class="mine">
            <h1><%=title %></h1>
            <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
        </div>
    </div>
    <div class="tbody">
        <div class="mine">
            <ERUN360:bmnav runat="server" ID="bmnav" />
            <div class="tbodyBox">
                <div class="event this clearfix">
                    <form id="form1" runat="server">
                        <asp:Literal ID="ltlbmh" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlbm" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlfjxh" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlfjx" runat="server"></asp:Literal>

                        <asp:Literal ID="ltljdh" runat="server"></asp:Literal>
                        <asp:Literal ID="ltljd" runat="server"></asp:Literal>
  
                        <asp:Literal ID="ltljth" runat="server"></asp:Literal>
                        <asp:Literal ID="ltljt" runat="server"></asp:Literal>
  
                        <asp:Literal ID="ltllyh" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlly" runat="server"></asp:Literal>
   
                        <asp:Literal ID="ltlzbh" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlzb" runat="server"></asp:Literal>
                        <asp:ImageButton ID="imgbtnpayall" runat="server" CssClass="gobus payallbuttom" ImageUrl="~/Html/images/pay.png" OnClick="imgbtnpayall_Click" />
                        <asp:Literal ID="ltlwfkh" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlwfk" runat="server"></asp:Literal>
                       
                    </form>
                </div>
            </div>
        </div>
    </div>
    <style>
        .payall a {
            position: absolute;
            right: 84px;
            top: 13px;
            background: #fcac01 none repeat scroll 0 0;
            line-height: 32px;
            width: 84px;
             text-align: center;
             color: #fff;
        }
       .payallbutt em:first-child{ color: #ccc;padding: 0 6px;vertical-align:top;}
       .payall b {color:red;font-weight: 100}
       .payall h4 em:last-child{display: none;}
    </style>
<ERUN360:footerv3 runat="server" ID="footerv3" />