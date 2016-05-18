<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Focus.aspx.cs" Inherits="infocenter_Focus" %>
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
                <span class="equip-ous">�ҵĹ�ע</span>
            </div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <%=FocusList %>
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
    $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
    // ȡ����עajax
    function cFocus(idx, foucs) {
        if (confirm("ȷ��Ҫȡ����ע��") == true) {
            $.get("/action/GetFoucsList.ashx", { uId: idx, command: "delFoucs", timestamp: new Date().getTime() }, function (result) {
                if (result == "1") {
                    $(".toast").html('ȡ����ע�ɹ�').show().addClass('toast-success')

                } else {
                    $(".toast").html('ȡ����עʧ��').show().addClass('toast-error')
                }
                var thisa = "." + foucs;
                function thisare() {
                    $(thisa).parent("li").remove()
                }
                setTimeout(thisare, 2000);
            });
        }
    errorboxhide()
    }
</script>
</form>
<ERUN360:footerv3 runat="server" ID="footerv3" />