<%@ Page Language="C#" AutoEventWireup="true" CodeFile="findpeople.aspx.cs" Inherits="infocenter_findpeople" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<form id="form1" runat="server">
<article>
<ERUN360:Erun_Left runat="server" ID="Erun_Left" />
<div class="main-right">
    <div class="sfbox">
        <div class="tfirend tfirendk">
            查找好友<i>&bull;</i>
            <span>可能感兴趣的人</span>
        </div>
		<div class="serfriend">
			<input type="text" id="taword" placeholder="查找好友">
            <a onclick="SearchTa();" class="serch" href="javascript:void(0)">搜索</a>
		</div>
		<div class="ffindtip">
			<%=searchTip %>
		</div>
        <%=UserList %>
        <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
            NextPageText="下一页" CssClass="pages"
            CurrentPageButtonClass="cpb" PrevPageText="上一页"
            OnPageChanged="pager_PageChanged" PageSize="12" UrlPaging="True">
        </webdiyer:AspNetPager>
    </div>
</div>
</article>
</form>
<script>
	function SearchTa(){
    if(document.getElementById("taword").value.length > 0){
        window.location.href = "\/infocenter\/findpeople.aspx?uId=<%=uId%>&searchname="+document.getElementById("taword").value
        return true;
    }
    return false;
}
function iFocus(idx,thisa) {
    var thisa = "."+thisa;
        function thisare() {
            $(thisa).replaceWith("<a class=\"focus-tygz\">相互关注</a>")
        }
        $.get("/action/GetFoucsList.ashx", { uId: idx, command: "addFoucs", timestamp: new Date().getTime() }, function (data) {
            if (data == "1") {
                $(".toast").html('关注成功').show().addClass('toast-success')
            } else {
                $(".toast").html(data).show().addClass('toast-error')
            }
            setTimeout(thisare, 2000);
            errorboxhide()
        });
}
    $('#taword').bind('keypress', function (event) {
        if (event.keyCode == "13") {
            SearchTa()
        }
    });
$(".focus-tly").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />