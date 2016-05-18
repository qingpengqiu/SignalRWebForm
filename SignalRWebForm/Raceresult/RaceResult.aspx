<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceResult.aspx.cs" Inherits="Raceresult_RaceResult" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style>
@media screen and (min-width:100px) and (max-width:800px) {
.quertime span{display: inline-block;width: 100%;text-align: left;padding-left: 10%;line-height: 2em}
.quertime span em{margin: 0;padding: 0;border: 0}
.querytimelist{border: 0;border-bottom: 1px solid #ddd}
.querytimelist li{width: 40%;margin-bottom: 0;border-top: 1px solid #ddd}
.querytimelist li:nth-child(2n){width: 60%;}
.querytimelist li:nth-child(6n){border-top:1px solid #ddd;}
.pclook{display: block;text-align: center;line-height: 100px;color: red}
.lookzs{display: none;}
}
</style>
<form  id="rpfrom" runat="server">
<article>
    <div class="resultquerys">
        <div class="querytopimg">
            <asp:Literal ID="ltlImg" runat="server"></asp:Literal>
        </div>
         <h1><asp:Literal ID="ltlTitle" runat="server"></asp:Literal></h1> 
        <h2><asp:Literal ID="ltlName" runat="server"></asp:Literal></h2>
        <div class="quertime">
    <span>完赛时间：<em> <asp:Literal ID="ltlTime" runat="server"></asp:Literal></em></span><asp:Literal ID="ltlNetTime" runat="server"></asp:Literal><span>组别：<em> <asp:Literal ID="ltlItem" runat="server"></asp:Literal>  </em></span><span>参赛号码：<em> <asp:Literal ID="ltlBib" runat="server"></asp:Literal> </em></span><span>本组名次：<em> <asp:Literal ID="ltlGroupRank" runat="server"></asp:Literal>  </em></span><span>总名次：<em> <asp:Literal ID="ltlRank" runat="server"></asp:Literal> </em></span>
        </div>
        <div class="querytimelist">
            <ul>
                <asp:Literal ID="ltlResult" runat="server"></asp:Literal>
            </ul>
        </div>
        <div class="pclook" id="pclook" runat="server">请到电脑端打印证书</div>
        <asp:LinkButton ID="lbtOK" runat="server" CssClass="lookzs" OnClick="lbtOK_Click">查看证书</asp:LinkButton>
    </div>
</article>
</form>
<script type="text/javascript">
jQuery(document).ready(function($) {
    $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
    if (data.status == '-1' ) {
         PopupShowdl();
         StatusCheck();
    }
});
});
custom = function(){
$.get('/action/AjaxUser.ashx?op=getuser', function(data) {
    if (data.status == 1 ) {
        location.reload()  
    }
});
}

</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />