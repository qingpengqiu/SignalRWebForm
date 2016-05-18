<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BaseInfo.aspx.cs" Inherits="infocenter_BaseInfo" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="baseinfobox">
            <div class="equip"><span class="equip-ous tashow">TA的跑界名片</span><a href="/infocenter/Account.aspx" id="editbase">编辑</a></div>
            <div class="basethumb">
                <img src="">
            </div>
            <div class="baseinfo">
                <span><i>哪年开始跑步：</i><asp:literal runat="server" id="lblrunyear"></asp:literal></span>
                <span><i>参加过多少场马拉松：</i><asp:literal runat="server" id="lbliMarathon"></asp:literal></span>
                <span><i>参加过多少场越野跑：</i><asp:literal runat="server" id="lbliTrail"></asp:literal></span>
                <span><i>马拉松最好成绩：</i><asp:literal runat="server" id="lbliMarathontype"></asp:literal> <asp:literal runat="server" id="lbltMarathontime"></asp:literal></span>
                <span><i>个人最满意的一场比赛：</i><asp:literal runat="server" id="lblcBio"></asp:literal></span>
                <p>
                    <em>赛事记录：</em>
                    <asp:Repeater ID="rptrunrecord" runat="server">
                        <ItemTemplate>
                            <span><%#Eval("iYear").ToString()%>年<%#Eval("cRacename").ToString()%>&nbsp;&nbsp;<%#Eval("tTime").ToString()%></span>
                         </ItemTemplate>
                    </asp:Repeater>
                </p>
            </div>
        </div>
    </div>
</article>
<script type="text/javascript">
    $(".basethumb img").attr('src', $.AMUI.store.get('leftuserinfo').cAvatar);
jQuery(document).ready(function($) {
    custom()
});
custom = function(){
    $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
        if (data.msg == $.AMUI.store.get('leftuserinfo').id) {
            $("#editbase").attr('href', '/infocenter/Account.aspx?uId='+data.msg).show()
            $(".tashow").html('我的跑界名片')
        }
    });
}
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />