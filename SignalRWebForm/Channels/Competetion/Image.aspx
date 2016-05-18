<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Image.aspx.cs" Inherits="Channels_Competetion_Image" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<article>
<div class="gameimg">
    <div class="crumbs"><a href="/Channels/Competetion/Album.aspx?f=<%=fid%>"><%=pName%></a> &gt; <a href="/Channels/Competetion/Photo.aspx?id=<%=id%>"><%=fName%></a></div>
        <div class="gamesimg" id="indecen">
        <%if (prv == "") %><%{ %>
        <a  class="giup gibjno"></a>
        <%} %><%else %><%{ %>
        <a href="/Channels/Competetion/Image.aspx?id=<%=id%>&name=<%=prv%>#indecen" class="giup"></a>
        <%} %>
        <a href="<%=HostInfo.imgCDN%><%=path%>largePics/<%=name%>.jpg" title="点击下载原图" target="_blank" class="thumbshowv3"><img src="<%=HostInfo.imgCDN%><%=path%>NormalPics/<%=name%>.jpg"  /></a>
        <%if (next == "") %><%{ %>
        <a class="gidown gibjno"></a>
        <%} %><%else %><%{ %>
        <a href="/Channels/Competetion/Image.aspx?id=<%=id%>&name=<%=next%>#indecen" class="gidown"></a>
        <%} %>
        </div>
    
</div>
</article>
<ERUN360:footerv3 runat="server" ID="footerv3" />