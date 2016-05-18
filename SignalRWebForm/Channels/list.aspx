<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="Channels_list" %>

<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<div class="V3Center">
    <div class="V3Left">
        <div class="listtitlel">
            <asp:literal runat="server" id="ltlImg"></asp:literal>
            <h3>
                <asp:literal id="ltlTitle" runat="server"></asp:literal>
            </h3>
        </div>
        <div class="V3ConsultList">
            <asp:literal id="ltlBlog" runat="server"></asp:literal>
            <div class="newsmore" id="newsmorelist">更多文章</div>
        </div>
    </div>
    <div class="V3Righr">
        <%= addgg.ADList(80000,1,0) %>
        <asp:literal id="ltlTour" runat="server"></asp:literal>
        <%= addgg.ADList(80000,2,0) %>
        <%= addgg.ADList(80000,3,0) %>
        <%= addgg.ADList(80000,4,0) %>
        <%= addgg.ADList(80000,5,0) %>
        <%= addgg.ADList(80000,6,0) %>
        <%= addgg.ADList(80000,7,0) %>
    </div>
        <%= addgg.ADList(80000,8,0) %>
</div>
<script type="text/javascript">
jQuery(document).ready(function($) {
    cachedom(1,GetQueryString('id'),'cnlist')
});
$(window).scroll(function() {  
    if($(this).scrollTop() + $(window).height() + 100 >= $(document).height() && $(this).scrollTop() > 100) { 
        p++
        getmoreaction(p,GetQueryString('id'),'cnlist')
    }
})
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />
