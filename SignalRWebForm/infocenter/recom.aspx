<%@ Page Language="C#" AutoEventWireup="true" CodeFile="recom.aspx.cs" Inherits="infocenter_recom" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<form id="form1" runat="server">
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="sfbox">
			<div class="tfirend ">
                编辑推荐<i>&bull;</i>
				<span>特约专家</span>
			</div>
            <ul class="">
                <%=DV1 %>
            </ul>
			<div class="tfirend ">
                编辑推荐<i>&bull;</i>
				<span>明星跑者</span>
			</div>
            <ul class="">
                <%=DV2 %>
            </ul>
            <div class="tfirend ">
                编辑推荐<i>&bull;</i>
                <span>海外跑者</span>
            </div>
            <ul class="">
                <%=DV3%>
            </ul>
            <div class="tfirend ">
                编辑推荐<i>&bull;</i>
                <span>测评达人</span>
            </div>
            <ul class="">
                <%=DV4 %>
            </ul>
        </div>
    </div>
</article>
</form>
<script>
function SearchTa(){
if(document.getElementById("taword").value.length > 0){
    $(".serch").attr("href","\/infocenter\/findpeople.aspx?uId=100000605&searchname="+document.getElementById("taword").value)
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
$(".focus-tly").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />