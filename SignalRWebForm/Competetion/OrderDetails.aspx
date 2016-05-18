<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrderDetails.aspx.cs" Inherits="Competetion_OrderDetails" %>

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
        <asp:literal id="ltlbanner" runat="server"></asp:literal>
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
                        <h4><%=title %></h4>
                        项目：<asp:literal id="ltlItem" runat="server"></asp:literal>
                        <br>
                        价格：￥<i><asp:literal id="ltlCost" runat="server"></asp:literal></i>
                        <asp:literal id="ltlpay" runat="server"></asp:literal>
                        <asp:literal id="ltlbibResult" runat="server"></asp:literal>
                        <%-- <a class="fkbuttom" href="">立即付款</a>--%>
                    </div>
                    <div class="othercp">
                        <div class="othertitle">选购其它产品：</div>
                        <asp:literal id="ltljd" runat="server"></asp:literal>
                        <%--<div class="otherlist minijd">
                                <a class="gobuy">加入购物车</a>
                                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a>
                                酒店价格：￥<i>160</i>
                                <div class="hotelthumb">
                                    <img src="/html/images/Feet4.png">
                                </div>
                                <a class="othermore">查看全部>></a>
                            </div>--%>
                        <%--<div class="otherlist minijt">
                                <a class="flynu">天津 → 北京<br>
                                    ￥<em>160</em>
                                </a><a class="flynu">天津 → 北京<br>
                                    ￥<em>160</em>
                                </a><a class="flynu">天津 → 北京<br>
                                    ￥<em>160</em>
                                </a><a class="flynu">天津 → 北京<br>
                                    ￥<em>160</em>
                                </a>
                                <br>
                                <a class="othermore">查看全部>></a>
                            </div>--%>
                        <%-- <div class="otherlist minily">
                                <a class="gobuy">加入购物车</a>
                                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a>
                                酒店价格：￥<i>160</i>
                                <div class="hotelthumb">
                                    <img src="/html/images/Feet4.png">
                                </div>
                                <a class="othermore">查看全部>></a>
                            </div>--%>
                        <asp:literal id="ltlzb" runat="server"></asp:literal>
                        <%-- <div class="otherlist minizb">
                                <a class="gobuy">加入购物车</a>
                                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a>
                                酒店价格：￥<i>160</i>
                                <div class="hotelthumb">
                                    <img src="/html/images/Feet4.png">
                                </div>
                                <a class="othermore">查看全部>></a>
                            </div>--%>
                        <%--<div class="otherlist miniqz">
                                <a class="gobuy">加入购物车</a>
                                <a href="" class="sptitle">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a>
                                酒店价格：￥<i>160</i>
                                <div class="hotelthumb">
                                    <img src="/html/images/Feet4.png">
                                </div>
                                <a class="othermore">查看全部>></a>
                            </div>--%>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<ERUN360:ICart runat="server" ID="ICart" />
<ERUN360:footerv3 runat="server" ID="footerv3" />