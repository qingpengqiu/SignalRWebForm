<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Photo.aspx.cs" Inherits="Channels_Competetion_Photo"  ClientTarget="uplevel" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<article>
    <div class="gameimg">
        <div class="crumbs"><a href="/Channels/Competetion/Album.aspx?f=<%=fid%>"><%=pName%></a> &gt; <%=fName%></div>
        <form id="form1" runat="server">
                <ul class="crumblist crumblistshow">
                    <asp:Repeater ID="DataList1" runat="server" >
                <ItemTemplate>
                    <li>
                        <a href="/Channels/Competetion/Image.aspx?id=<%=id%>&name=<%#Eval("Name") %>" target="_blank" class="group1">
                                <img  src="<%=HostInfo.imgCDN%><%#Eval("SmallPhoto").ToString().Replace("~","")%>" />
                                <p><%#Eval("Name") %></p>
                            </a>
                            
                    </li>
                </ItemTemplate>
            </asp:Repeater>
                </ul>
            <div class="crumbspage">
                <asp:LinkButton ID="lbnPrevPage" runat="server" CommandName="prev" OnCommand="Page_OnClick">上一页</asp:LinkButton>
                <asp:Label ID="lbCurrentPage" runat="server" Text=""></asp:Label>
                &nbsp;&nbsp;<asp:Label ID="lbTotal" runat="server" Text=""></asp:Label>
                <asp:LinkButton ID="lbnNextPage" runat="server" CommandName="next" OnCommand="Page_OnClick">下一页</asp:LinkButton>
                &nbsp;&nbsp;跳转至第<asp:DropDownList ID="lstPage" runat="server" OnSelectedIndexChanged="lstPage_SelectedIndexChanged1" AutoPostBack="True">
                </asp:DropDownList>页&nbsp;
            </div>
        </form>
    </div>
</article>
<ERUN360:footerv3 runat="server" ID="footerv3" />