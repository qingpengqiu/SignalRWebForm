<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Comments.aspx.cs" Inherits="infocenter_Comments" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="equip"><span class="equip-ous"><em></em>新收到的评论</span></div>
        <ul class="comments">
            <li id="c04" class="listmore">查看更多</li>
        </ul>                
    </div>
</article>
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        InitTable("#c04");
    });
    $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
    function InitTable(divid) {
        $.ajax({
            type: "POST",
            dataType: "text",
            url: '/action/CommentList.ashx',      //提交到一般处理程序请求数据
            data: "command=discuss",
            beforeSend: function () {
                $(divid).html("<span class=\"load\"></span>正在加载中...");
            },
            success: function (data) {
                $(".comments li").remove();
                $(".comments").append(data);
                $('.comments').emotions();
            }
        });
    }
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />