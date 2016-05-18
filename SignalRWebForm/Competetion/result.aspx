<%@ Page Language="C#" AutoEventWireup="true" CodeFile="result.aspx.cs" Inherits="Competetion_result" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
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
                    <div class="query">
                        <label>请输入参赛姓名:</label>
                        <asp:TextBox ID="tbname" runat="server"></asp:TextBox>
                         <label id="lbNo" runat="server">请输入证件号码:</label>
                       <%-- <label id="lbNo">请输入证件号码:</label>--%>
                        <asp:TextBox ID="idNo" runat="server"></asp:TextBox>
                        <asp:ImageButton ID="Imgbtn" runat="server" ImageUrl="/Html/images/cx.png" OnClick="Imgbtn_Click" />
                        
                    </div>
                    <div class="queryr">
                        <div class="querb">
                            <asp:Literal ID="ltlInfo" runat="server"></asp:Literal>
                        </div>
                        <div class="resultbz" runat="server" id="cmarkbz"><%=cmark %></div>
                        <div class="rtimelist">
                            <asp:Literal ID="ltlPart" runat="server"></asp:Literal>
                            
                                
                            
                            <ul>
                                <asp:Literal ID="ltlResult" runat="server"></asp:Literal>
                            </ul>
                        </div>
                       <div class="pclook" id="pclook" runat="server" visible="false">请到电脑端打印证书</div>
                        <asp:LinkButton ID="lbtOK" runat="server" CssClass="lookzs" OnClick="lbtOK_Click" Visible="False">查看证书</asp:LinkButton>
                    </div>
                    
                    </form>
                </div>
            </div>
        </div>
    </div>
<ERUN360:footerv3 runat="server" ID="footerv3" />