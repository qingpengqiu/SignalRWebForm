<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Album.aspx.cs" Inherits="Channels_Competetion_Album" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<article>
    <div class="crumbs"></div>
    <ul class="crumblist">
        <li class="listmore" id="c01">点击加载更多</li>
    </ul>
</article>
<script>
    if (GetQueryString("f")) {
        id = GetQueryString("f")
    } else {
        id = "1"
    }
    function SerachPage() {
        divid = "#c01";
        $.ajax({
            url: '/action/GetPhoto.ashx',
            data: { m: "photo2", p: pageIndex, f: id },
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $(divid).html("<span class=\"load\"></span>正在加载中");
            },
            success: function (data) {
                var pagenum = data.count,
                    pagedata = data.ds
                $.each(pagedata, function (i) {
                    if (pagedata[i].tag == "True") {
                        if (pagedata[i].idRace == "") {
                            $(divid).before("<li><a href=\"/Channels/Competetion/Album.aspx?f=" + pagedata[i].id + "\" target=\"_blank\"><img src=\"" + pagedata[i].cImg.replace(/img.erun360/, "cdnimg.erun360") + "\" alt=\"\" /><p>" + pagedata[i].cName + "</p></a></li>");
                        }
                        else {
                            $(divid).before("<li><a href=\"/Competetion/gallery.aspx?sid=" + pagedata[i].idRace + "&nav=11\" target=\"_blank\"><img src=\"" + pagedata[i].cImg.replace(/img.erun360/, "cdnimg.erun360") + "\" alt=\"\" /><p>" + pagedata[i].cName + "</p></a></li>");
                        }
                    } else {
                        if (pagedata[i].idRace == "") {
                            $(divid).before("<li><a href=\"/Channels/Competetion/Photo.aspx?id=" + pagedata[i].id + "\" target=\"_blank\"><img src=\"" + pagedata[i].cImg.replace(/img.erun360/, "cdnimg.erun360") + "\" alt=\"\" /><p>" + pagedata[i].cName + "</p></a></li>");
                        }
                        else {
                            $(divid).before("<li><a href=\"/Competetion/gallery.aspx?sid=" + pagedata[i].idRace + "&nav=11\" target=\"_blank\"><img src=\"" + pagedata[i].cImg.replace(/img.erun360/, "cdnimg.erun360") + "\" alt=\"\" /><p>" + pagedata[i].cName + "</p></a></li>");
                        }
                      
                    }

                })
                thiscount = data.count;
                if (data.parent == 0) {
                    pname = ""
                } else {
                    pname = "<a href=\"/Channels/Competetion/Album.aspx?f=" + data.parent + "\">" + data.pname + "</a> > "
                }

                tname = data.name
                $(".crumbs").html(pname + tname)
            },
            complete: function () { //生成分页条
                if (thiscount == "") {
                    $(divid).html("木有了");
                } else {
                    $(divid).html("点击加载更多");
                }
            },
            error: function (xhr) {
            }

        });
    }
    pageIndex = 1;
    SerachPage();
    $("#c01").click(function () {
        pageIndex++
        SerachPage();

    })
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />