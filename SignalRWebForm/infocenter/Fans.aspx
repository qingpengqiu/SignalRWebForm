<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fans.aspx.cs" Inherits="infocenter_Fans" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<form id="form1" runat="server">
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="main-right ">
        <div class="blog focus">
            <div class="equip">
                <span class="equip-ous">�ҵķ�˿</span>
            </div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <%=FansList %>
                    <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                        NextPageText="��һҳ" CssClass="pages"
                        CurrentPageButtonClass="cpb" PrevPageText="��һҳ"
                        OnPageChanged="pager_PageChanged" PageSize="12" UrlPaging="True">
                    </webdiyer:AspNetPager>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</article>
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $(".close").click(function () {
            $(".message").hide();
        });
    });
    $(".new-classify").colorbox({ iframe: true, width: "647px", height: "423px" });
    function iFocus(idx,thisa) {
        var thisa = "."+thisa;
            function thisare() {
                $(thisa).replaceWith("<a class=\"focus-a focus-xh\">�໥��ע</a>")
            }
            $.get("/action/GetFoucsList.ashx", { uId: idx, command: "addFoucs", timestamp: new Date().getTime() }, function (data) {
                if (data == "1") {
                    $(".toast").html('��ע�ɹ�').show().addClass('toast-success')
                } else {
                    $(".toast").html('��עʧ��').show().addClass('toast-error')
                }
                setTimeout(thisare, 2000);
            });
        errorboxhide()
    }
    //����
    $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
</script>
</form>
<ERUN360:footerv3 runat="server" ID="footerv3" />