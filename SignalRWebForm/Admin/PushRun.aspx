<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PushRun.aspx.cs" Inherits="Admin_PushRun" %>

<!DOCTYPE html>

<html>
<head>
    <title>详细(BlogPublish)-数据维护-ERUN360.COM</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../Common/jCity.js"></script>
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body leftmargin="0" topmargin="0">
    <!-- 信息开始 -->
    <div id="pageContent">
        <form id="form1" runat="server">
            <table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse: collapse;">
                <tr>
                    <td align="right" valign="top" style="width: 90px;" nowrap>编号：</td>
                    <td>
                        <asp:Label ID="lbid" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" valign="top" nowrap>作者：</td>
                    <td>
                        <asp:Label ID="lbNickName" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" valign="top" nowrap>标题：</td>
                    <td>
                        <asp:Label ID="lbTitle" runat="server" Text=""></asp:Label><br>
                        标题修改为:
                        <input type="text" id="new_title" runat="server" name="new_title" size="60" value="">
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top" nowrap>摘要：</td>
                    <td>
                        <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top">发布于：</td>
                    <td>
                        <asp:DropDownList ID="ddlClass" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top">焦点图：</td>
                    <td>
                        <input type="file" class="input-large fileupload"><input type="hidden" id="jdtp" name="hdtt" runat="server" />
                        <label>图片大小1M以下，360*200px</label></td>
                </tr>
                <tr>
                    <td align="right" valign="top" nowrap>推送时间：</td>
                    <td>
                        <input id="pushtime" runat="server" class="Wdate input-large" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'%y-%M-#{%d}'})" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="color: #EE0000;">
                        <% =BlogList %>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top"></td>
                    <td>
                        <div style="float: left; width: 100px; height: 32px;">
                            <asp:ImageButton ID="imgbtn" runat="server" ImageUrl="/Images/submit.gif" OnClick="imgbtn_Click" />
                            <%--<img src="/Images/submit.gif" onclick="Finish()">--%>
                        </div>
                        <div id="total_echo" style="float: left; width: 300px; height: 22px; padding-top: 10px;" class="check_echo">
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <script type="text/javascript">
        $(".fileupload").change(function () {
            var data = new FormData(),
               sthis = $(this)
            $.each(sthis[0].files, function (i, file) {
                data.append('upload_file', file);
            });
            $.ajax({
                url: '/action/fileUp.ashx?name=Filedata',
                type: 'POST',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    var data = data[0]
                    if (data.status == 1) {
                        sthis.next("input").val(data.url)
                        tipbox(data.message, 'success')

                    } else {
                        tipbox(data.message, 'error')
                    }
                }
            });
        });
        function ItemDelete(idx, pos) {
            if (confirm("确定要删除本行记录吗？") == true) {
                $.get("pushdel.aspx", { id: idx }, function (result) {
                    if (result == "OK") {
                        $("#trData_" + pos)[0].style.display = "none";
                    }
                    else {
                        alert(result);
                    }
                });
            }
        }
        // 提示插件   tipbox('提示内容','success||error','停留时间默认2秒')
        var tipbox = function (tip, status, time) {
            var demo = '<div id="toastfun" class="toastfun toastfun-' + status + '">' + tip + '</div>'
            $("body").append(demo)
            setTimeout(function () {
                $("#toastfun").remove()
            }, time ? time : 2000)
        }
    </script>
</body>
</html>
