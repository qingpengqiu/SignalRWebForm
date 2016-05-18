<%@ Page Language="C#" AutoEventWireup="true" CodeFile="equipment.aspx.cs" Inherits="Competetion_equipment" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
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
            <div class="eqma">
                <div class="eqmal eqmalsmall">
                    <a class="eqmaa eqmazb" href="javascript:void(0)">装备<i></i></a>
                </div>
                <div class="eqmar am-form ">
                    <div class="equilist">                            
                        <asp:Literal ID="ltlequip" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<ERUN360:ICart runat="server" ID="ICart" />
<ERUN360:footerv3 runat="server" ID="footerv3" />