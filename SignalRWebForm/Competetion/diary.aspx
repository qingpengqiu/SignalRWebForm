<%@ Page Language="C#" AutoEventWireup="true" CodeFile="diary.aspx.cs" Inherits="Competetion_diary" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
<div class="banner">
    <div class="mine">
        <h1><%=title %></h1>
        <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
    </div>
</div>
<div class="tbody">
    <div class="mine">
        <ERUN360:bmnav runat="server" ID="bmnav" />
        <div class="tbodyBox">
            <div class="event this clearfix">
                <div class="diary">
                    <div class="diarytitle">相关赛记</div>
                </div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var template = '<div class="diaryli">\
                            <a class="diaryicon" href="/user/{idUser}.aspx"><img src="{cAvatar}"></a>\
                            <a class="diarytitlehref" href="/blog/{id}.aspx">{cTitle}</a>\
                            <p>{cContent}</p>\
                            <img src="{Thumbnails}" class="diarythumb">\
                            <div class="diaryinfo"><i>{dCreate}</i>阅读({iShowTimes}) 关注({iFocus}) 顶({iDing}) 评论({iDiscuss})</div>\
                        </div>',
        list='';

jQuery(document).ready(function($) {
    $.get('/action/EventService.ashx?op=blog',{sid:<%=sid%>}, function(data) {
    if(data.status == 0){
        $(".diary").append('<div class="diaryno">'+data.msg+'</div>')
        return false
    }
    $.each(data, function(index, val) {
        list += nano(template, val)
    });
    $(".diary").append(list)
    if (jQuery.isEmptyObject(data)) {
        $(".armore").html('当前无赛事')
    }else{
        $(".armore").html('点击加载更多')
    }
    });


});

function nano(template, data) {
  return template.replace(/\{([\w\.]*)\}/g, function(str, key) {
    var keys = key.split("."), v = data[keys.shift()];
    for (i = 0, l = keys.length; i < l; _i++) v = v[this];
    return (typeof v !== "undefined" && v !== null) ? v : "";
  });
};



    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />