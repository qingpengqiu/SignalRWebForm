<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hotel.aspx.cs" Inherits="Competetion_hotel" %>
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
                    <div class="eqma">
                        <div class="eqmal eqmalsmall">
                            <a class="eqmaa eqmajd" href="javascript:void(0)">酒店<i></i></a>
                        </div>
                        <div class="eqmar am-form ">
                            <div class="equilist">
                                <%--<div class="hotellist">
                                    <img src="http://119.2.5.59:8081/utility/uploads/2015/07/02/100000002_105241069.gif" class="hotelthumb">
                                    <div class="hoteltitle">
                                        <a href="">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a> <a class="hoteleidt">[ 编辑 ]</a>
                                    </div>

                                    酒店价格：<em>&yen;160</em><i>起</i>
                                    <br>
                                    三人房标准间（含早餐）
                                    <br>
                                    双人房标准间（含早餐）
                                    <br>
                                    套间（含早餐）
                                    <br>
                                    <a href="javascript:void(0)" class="equilgo">立即购买</a>
                                </div>--%>
                                <asp:Literal ID="ltlhotel" runat="server"></asp:Literal>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <ERUN360:ICart runat="server" ID="ICart" />
<ERUN360:footerv3 runat="server" ID="footerv3" />

