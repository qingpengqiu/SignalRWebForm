<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Photo.aspx.cs" Inherits="Competetion_Photo" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<script src="/assets/js/jquery.blueimp-gallery-edit.min.js"></script>
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
                    <div class="photolist">
                        <div class="photothumb">
                            <div class="lightBoxGallery">
                            <asp:Repeater ID="DataList1" runat="server">
                                <ItemTemplate>
                                    <a href="<%=HostInfo.imgCDN%><%#Eval("NormalPhoto").ToString().Replace("~","")%>" title="<%#Eval("Name") %>" data-gallery=""><img src="<%=HostInfo.imgCDN%><%#Eval("SmallPhoto").ToString().Replace("~","")%>"><%#Eval("Name") %></a>
                                </ItemTemplate>
                            </asp:Repeater>
                            <div id="blueimp-gallery" class="blueimp-gallery">
                                <div class="slides"></div>
                                <h3 class="title"></h3>
                                <a class="prev"></a>
                                <a class="next"></a>
                                <a class="close">×</a>
                                <a class="play-pause"></a>
                                <ol class="indicator"></ol>
                                <a class="bigimg" target="_blank">查看大图</a>
                            </div>
                            </div>
                        </div>
                        <div class="gmpage">
                            <asp:ImageButton ID="lbnPrevPage" runat="server" CommandName="prev" OnCommand="Page_OnClick" ImageUrl="~/Html/images/v3left.png"  />
                            <%--<asp:LinkButton ID="lbnPrevPage" runat="server" CommandName="prev" OnCommand="Page_OnClick">上一页</asp:LinkButton>--%>
                            <asp:Label ID="lbCurrentPage" runat="server" Text=""></asp:Label>
                            &nbsp;&nbsp;<asp:Label ID="lbTotal" runat="server" Text=""></asp:Label>
                            <asp:ImageButton ID="lbnNextPage" runat="server" CommandName="next" OnCommand="Page_OnClick" ImageUrl="~/Html/images/v3right.png"  />
                           <%-- <asp:LinkButton ID="lbnNextPage" runat="server" CommandName="next" OnCommand="Page_OnClick">下一页</asp:LinkButton>--%>
                            &nbsp;&nbsp;跳转至第<asp:DropDownList ID="lstPage" runat="server" OnSelectedIndexChanged="lstPage_SelectedIndexChanged1" AutoPostBack="True">
                            </asp:DropDownList>页&nbsp;
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
<div class="phototipboxbg"></div>
<div class="phototipbox">
    <div class="pcbox">
        键盘上的<span>左右键</span>可以翻页
        <a class="knowtip">知道了</a>
    </div>
    <div class="medabox">
        屏幕上<span>左右滑动</span>可以翻页
        <a class="knowtip">知道了</a>
</div>
</div>
<script type="text/javascript">
    var store = $.AMUI.store;
    $(".lightBoxGallery img").click(function(event) {
        if (!store.get('knowtip')) {
            $(".phototipboxbg").show()
            $(".phototipbox").show()
        };
    });
    $(".knowtip").click(function(event) {
        $(".phototipboxbg").hide()
        $(".phototipbox").hide()
        store.set('knowtip', '1')
    });
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />