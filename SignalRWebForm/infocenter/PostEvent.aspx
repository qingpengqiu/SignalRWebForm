<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostEvent.aspx.cs" Inherits="infocenter_PostEvent" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%--<%@ Register Assembly="UEditorControl" Namespace="UEditorControl" TagPrefix="cc1" %>--%>

<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link href="/Html/css/Calendar.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />

    <link rel="stylesheet" type="text/css" href="../Html/css/user-more.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/jCalendar.js"></script>

    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap-validation.min.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../Common/jCity.js"></script> 
    <script src="../Common/jCheck.js"></script>
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
    <script src="../Html/js/jquery.blockUI.js"></script>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
    <style type="text/css">
        .main-left ul .left6 img {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }

        .main-left ul .left6 a {
            color: #693f69;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
        <div class="wrap">
            <article>
                <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
                <div class="main-right">
                    <div class="blog ">
                        <div class="blog-top">发赛事</div>
                        <div class="to-run">
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            <label for="title">名称:</label></td>
                                        <td>
                                            <input type="text" runat="server" name="title" id="title" value="" tabindex="1" class="input-xlarge" maxlength="60" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top" style="width: 120px;">竞赛类型：</td>
                                        <td>
                                            <%-- <% =GCommon.Controls("竞赛类型", "select", "idCompeteStyle", iCompeteStyle) %>--%>
                                            <select id="idCompeteStyle" name="idCompeteStyle" runat="server">
                                                <option value="all" selected>请选择</option>
                                                <option value="0">U超级马拉松</option>
                                                <option value="1">M全程马拉松</option>
                                                <option value="2">H半程马拉松</option>
                                                <option value="3">R路跑</option>
                                                <option value="4">C越野跑</option>
                                                <option value="5">T其它</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top">所在城市：</td>
                                        <td>
                                            <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server">
                                            </select>
                                            <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server">
                                            </select>
                                            <script type="text/javascript">
                                                BindProvince("北京");
                                            </script>
                                            <%--   <input type="text" id="idCity" name="idCity" size="5" readonly value="<% =idCity %>">
                                            <input type="text" id="cCityname" name="cCityname" size="15" readonly value="<% =Cityname %>">--%>
                                            <input type="text" id="idCity" name="idCity" size="5" readonly value="0" runat="server">
                                            <input type="text" id="cCityname" name="cCityname" size="15" readonly value="" runat="server">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top">赛事时间：</td>
                                        <td>
                                            <input id="dRaceBegin" runat="server" name="dRaceBegin" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd',minDate:'%y-%M-#{%d}'})" />
                                            <%--<input type="text" id="dRaceBegin" name="dRaceBegin" size="18" maxlength="22" value="<% =RaceBegin %>" onclick="GDate(this);" />--%>
                                            - 
                                            <input id="dRaceEnd" runat="server" name="dRaceEnd" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd',minDate:'%y-%M-#{%d}'})" />
                                            <%--<input type="text" id="dRaceEnd" name="dRaceEnd" size="18" maxlength="22" value="<% =RaceEnd %>" onclick="GDate(this);" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top">报名时间：</td>
                                        <td>
                                            <input id="dJoinBegin" runat="server" name="dJoinBegin" class="Wdate input-large" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'%y-%M-#{%d}'})" />
                                            <%--<input type="text" id="dJoinBegin" name="dJoinBegin" size="18" maxlength="22" value="<% =JoinBegin%>" onclick="GDate(this);" />--%>
                                            - 
                                             <input id="dJoinEnd" runat="server" name="dJoinEnd" class="Wdate input-large" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'%y-%M-#{%d}'})" />
                                            <%--<input type="text" id="dJoinEnd" name="dJoinEnd" size="18" maxlength="22" value="<% =JoinEnd%>" onclick="GDate(this);" />--%>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="textarea-post">
                                <textarea name="cContentUEditor" id="cContentUEditor" runat="server"></textarea>
                            </div>

                            <script src="../UEditor/ueditor.config.js"></script>
                            <script src="../UEditor/ueditor.all.js"></script>

                            <script type="text/javascript">
                                var editor = new UE.ui.Editor();
                                editor.render("cContentUEditor");
                            </script>
                            <input type="hidden" runat="server" id="UpdatedFields" name="UpdatedFields" value="">
                            <div class="control-group " style="margin-top: 40px;">
                                <div class="controls">
                                    <asp:ImageButton ID="imgbtCompetetion" runat="server" ImageUrl="~/Html/images/save.png" OnClick="imgbtCompetetion_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </article>
        </div>       
        <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        <script type="text/javascript">

            jQuery(document).ready(function ($) {
                $(".close").click(function () {
                    $(".message").hide();
                });
            });
            $(".new-classify").colorbox({ iframe: true, width: "647px", height: "423px" });

            function tips(msg, url, imgname) {
                var img = "<img src=\"\/Html\/images\/" + imgname + "\.png\">"
                $("#tips").append(img).append(msg);


                $.colorbox({ inline: true, width: "50%", href: "#tips", width: "254px", height: "141px", opacity: "0.4" });
                var url = url;
                if (url == "") {
                    setTimeout("$.colorbox.close();", 5000)

                } else {
                    setTimeout("location.href = \"" + url + "\"", 3000)
                }

            }
            $(".tshirt").colorbox({ rel: 'tshirt' });
            var iCity = parseInt(<% =iCity %>) - 1
            _province = china[iCity][0];
            $("#ddlProvince").val(china[iCity])
            for (x in china[iCity]) {
                if (x != 0) {
                    if (x == [<% =iArea  %>]) {
                        $("#ddlCity").append('<option selected=\"selected\" value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
                    } else {
                        $("#ddlCity").append('<option value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
                    }
                }
            }
            var bdmapkey = "0",
                newzbkey = "0"
            $(".hdjmap").click(function (event) {
                $.colorbox({ inline: true, href: "#bdmap", width: "800px", height: "460px", opacity: "0.4" });
                cityname = $("#ddlProvince").val() + $("#ddlCity").val()
                if (cityname) {
                    cityname = "北京"
                }
                if (bdmapkey == "0") {
                    baidumap(cityname)
                }
            });
        </script>
    </form>
</body>
</html>
