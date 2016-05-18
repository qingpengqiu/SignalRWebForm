<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cnllist.aspx.cs" Inherits="Channels_cnllist" %>

<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<div class="V3Center">
    <div class="V3Left">
        <%--<div id="playBox" class="listlb" >
                <div class="pre"></div>
                <div class="next"></div>
                <div class="smalltitle">
                    <ul>
                        <asp:Literal ID="ltljdtdian" runat="server"></asp:Literal>
                    </ul>
                </div>
                <ul class="oUlplay">
                    <asp:Literal ID="ltljdt" runat="server"></asp:Literal>
                </ul>
            </div>
            <script type="text/javascript">pdlb()</script>--%>
        <asp:literal id="ltljdt" runat="server"></asp:literal>
        <div class="listtitle">
            <asp:literal id="ltlTitle" runat="server"></asp:literal>
        </div>
        <div class="V3ConsultList">
            <asp:literal id="ltlBlog" runat="server"></asp:literal>
            <div class="newsmore" id="newsmore">更多文章</div>
        </div>
    </div>
    <div class="V3Righr">
        <%= addgg.ADList(id,1,0) %>
        <asp:literal id="ltlTour" runat="server"></asp:literal>
        <%= addgg.ADList(id,2,0) %>
        <%= addgg.ADList(id,3,0) %>
        <%= addgg.ADList(id,4,0) %>
        <%= addgg.ADList(id,5,0) %>
        <%= addgg.ADList(id,6,0) %>
        <%= addgg.ADList(id,7,0) %>
    </div>
        <%= addgg.ADList(id,8,0) %>
</div>
<script type="text/javascript">
jQuery(document).ready(function($) {
    cachedom(1,GetQueryString('id'),'list')
});
$(window).scroll(function() {  
    if($(this).scrollTop() + $(window).height() + 100 >= $(document).height() && $(this).scrollTop() > 100) { 
        p++
        getmoreaction(p,GetQueryString('id'),'list')
    }
})
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />
