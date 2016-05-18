<%@ Page Language="C#" AutoEventWireup="true" CodeFile="gallery.aspx.cs" Inherits="Competetion_gallery" %>
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
                    <div class="photolist">
                        <asp:Literal ID="ltlImgList" runat="server"></asp:Literal>
                        <%--<div class="plist"><a href=""><img src="http://img.erun360.com/Photo/2015/xxtb/SmallPics/DT__6453.jpg">1号机位</a></div>
                        <div class="plist"><a href=""><img src="http://img.erun360.com/Photo/2015/xxtb/SmallPics/DT__6453.jpg">1号机位</a></div>
                        <div class="plist"><a href=""><img src="http://img.erun360.com/Photo/2015/xxtb/SmallPics/DT__6453.jpg">1号机位</a></div>
                        <div class="plist"><a href=""><img src="http://img.erun360.com/Photo/2015/xxtb/SmallPics/DT__6453.jpg">1号机位</a></div>
                        <div class="plist"><a href=""><img src="http://img.erun360.com/Photo/2015/xxtb/SmallPics/DT__6453.jpg">1号机位</a></div>--%>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<ERUN360:footerv3 runat="server" ID="footerv3" />