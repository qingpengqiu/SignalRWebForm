<%@ Page Language="C#" AutoEventWireup="true" CodeFile="singleEvent.aspx.cs" Inherits="infocenter_singleEvent" %>


<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %>


<!DOCTYPE html>

<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title><%=m_title %>-<%=m_nav %>-益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />

    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript">
        function imageResize(obj) {
            if (obj.width > 600) {
                obj.width = 600;
            }
        }
    </script>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
    <style type="text/css">
<%=StyleLeft %>
</style>
</head>
<body>
    <form id="form1" runat="server">
        <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
        <div class="wrap">
            <article>
                <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
                <div class="main-right">
                    <div class="blog">
                        <%=fullText %>
                        <div class="page">
                            <%=Previous %>
                            <br>
                            <%=Next %>
                        </div>
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        <div class="discuss">
                            我要评论：
                        </div>
                        <div class="discuss-border">
                            <div class="discuss-text">
                                <ERUN360:Phiz runat="server" ID="Phiz" />
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <textarea style="font-size: 14px; padding: 5px;" rows="3" cols="70" name="cContent" id="cContent" runat="server"></textarea><br>
                                        <asp:Label ID="lbtip" runat="server" ForeColor="Red"></asp:Label>
                                        <%if (cId == 0) %>
                                        <%{ %>
                                        <div class="discuss-login">
                                            <a href="/Member/">注册</a>|
                                            <a onclick="PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();" href="javascript:">登录</a>

                                        </div>
                                        <%} %>
                                        <%else %>
                                        <%{ %>
                                        <asp:Button ID="btnDiscuss" class="submit" runat="server" Text="提交" OnClick="btnDiscuss_Click" />
                                        <%} %>
                                    </div>
                                    <%=DiscussList %>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                    </div>
                </div>
            </article>
        </div>
        <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        <script type="text/javascript">
            $("#btnDiscuss").bind("click", function () {
                var postmsg = $("#cContent").val().replace(/(^\s+)|(\s+$)/g, "");
                if (postmsg == "") {
                    $(".discuss-text").append("<a class=\"tishi\">留言不能为空</a>")
                    return false;
                } else {
                    $(".tishi").empty();
                }

            });


            jQuery(document).ready(function ($) {
                $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
                $(".close").click(function () {
                    $(".message").hide();
                });
                var lheight = $(".main-right").height() - "16";
                if (lheight > "530") {
                    $(".main-left").css("height", lheight);
                }
                $('#text').emotions();
                //删除博客
                function GetQueryString(name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                }
                $(".blogdel").click(function () {
                    var blogDelUrl = $(this).attr("rel")
                    $.ajax({
                        url: blogDelUrl,
                        type: 'GET',
                        dataType: 'text',
                        success: function (data, textStatus, xhr) {
                            var strs = new Array();
                            strs = data.split(",");
                            if (strs[0] == "ok") {
                                focuscont = "<img src=\"/Html/images/right.png\"> 删除成功";
                            } else {
                                focuscont = "<img src=\"/Html/images/false.png\">" + data;
                            }
                            function blogDelHref() {
                                //setTimeout("location.href = \"/infocenter/" + strs[1] + "?uId=" + GetQueryString("uId") + "\"", 3000)
                                setTimeout("location.href = \"/infocenter/" + strs[1] + "?uId=<%=cId%> \"", 3000)
                            }
                            $(".blogdel").append("<div class=\"focusalert\">" + focuscont + "</div>");
                            setTimeout(blogDelHref, 200);
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //called when there is an error
                        }
                    });
                })

            });
            function EmotionAdd(v) {
                document.getElementById("cContent").value += "[" + v + "]";
            }
            $(".house").click(function () {
                setTimeout("$('.collect').hide()", 2000);
            })

            $(".art-del").click(function () {
                var qa = $(this).attr("href");
                $(".cancel_enter").attr("href", qa);
                $(this).colorbox({ inline: true, width: "50%", href: "#cancel", width: "254px", height: "141px", opacity: "0.4" });
            })
            $(".close_cancel").click(function () {
                $("#cancel").colorbox.close();
            })
            function Ding() {
                $.get("/action/GetBlogList.ashx?command=Ding&bId=<% =bId %>&rnd=" + Math.random(), function (result) {
                    document.getElementById("isDing").innerHTML = result;
                });
            }
            function iHouse() {
                $.get("/action/GetBlogList.ashx?command=iHouse&bId=<% =bId %>&rnd=" + Math.random(), function (result) {

                    if (result == "1") {
                        focuscont = "<img src=\"/Html/images/right.png\"> 关注成功";
                    } else {
                        focuscont = "<img src=\"/Html/images/false.png\">" + result;
                    }
                    function iHousere() {
                        setTimeout("$(\".focusalert\").remove()", 3000)
                    }
                    $(".house").append("<div class=\"focusalert\">" + focuscont + "</div>");
                    setTimeout(iHousere, 200);



                });
            }
            function JoinCreate(idUser, idx, bId) {
                $.get("/action/CompetitionList.ashx", { uId: idUser, id: idx, bId: bId, command: "FoucsCompetetion", rnd: Math.random() }, function (result) {
                    if (result == "OK") {

                        focuscont = "<img src=\"/Html/images/right.png\"> 关注成功";
                    }
                    else {
                        focuscont = "<img src=\"/Html/images/false.png\">" + result;
                    }
                    function iHousere() {
                        setTimeout("$(\".focusalert\").remove()", 3000)
                    }
                    $("#join_info").append("<div class=\"focusalert\">" + focuscont + "</div>");
                    setTimeout(iHousere, 200);
                });
            }
            function JoinCreate(idUser, idx, bId) {
                $.get("/action/CompetitionList.ashx", { uId: idUser, id: idx, bId: bId, command: "FoucsCompetetion", rnd: Math.random() }, function (result) {
                    if (result == "OK") {

                        focuscont = "<img src=\"/Html/images/right.png\"> 关注成功";
                    }
                    else {
                        focuscont = "<img src=\"/Html/images/false.png\">" + result;
                    }
                    function iHousere() {
                        setTimeout("$(\".focusalert\").remove()", 3000);
                        $("#guanzhu_info").replaceWith("<a id=\"foucs_ss1\">已关注</a>")

                    }
                    $("#guanzhu_info").append("<div class=\"focusalert\">" + focuscont + "</div>");
                    setTimeout(iHousere, 200);
                });
            }
            function huifuta(bid, uid, id) {
                $("#text .huifuk").remove();
                $.get("/action/GetMessageList.ashx", { command: "state" }, function (data) {
                    console.log(data)
                    if (data == "-1") {
                        PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                    } else {
                        $("#li" + id).append("<div class=\"huifuk\"><em></em>回复：<br><textarea id=\"reply\"></textarea><a class=\"reply\" onclick=\"replyd(" + bid + "," + uid + ")\" href=\"javascript:void(0)\">发送</a><a class=\"qreply\" onclick=\"qreply()\" href=\"javascript:void(0)\">取消</a></div>")
                    }
                });
            }
            function replyd(bid, uid) {
                msg = encodeURIComponent($("#reply").val());


                $.get("/action/GetMessageList.ashx", { command: "AddHuiFu", idBlog: bid, idUser: uid, op: "1", msg: msg }, function (data) {
                    if (data == "-1") {
                        PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                    } else if (data == "1") {
                        //location.replace(location+ "#text")
                        var replaceRegex = /\#text/g;
                        date = window.location.href.replace(replaceRegex, '')
                        location = date + "#text";
                        window.location.reload()
                        $("#reply").val("");
                        $(".huifuk").remove()
                    } else if (data == "0") {
                    }

                });
            }
            function qreply() {
                $(".huifuk").remove()
            }
        </script>
    </form>
</body>
</html>
