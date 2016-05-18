<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoesLinkEdit.aspx.cs" Inherits="Admin_ShoesLinkEdit" %>

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
</head>
<body leftmargin="0" topmargin="0">
    <!-- 信息开始 -->
    <div id="pageContent">
        <form id="form1" runat="server">
            <input type="hidden" id="linktype" name="linktype" value="<%=linktype %>" />
            <table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse: collapse;">
                <tr>
                    <td align="right" valign="top" style="width: 90px;" nowrap>鞋编号：</td>
                    <td><asp:Label ID="lblshoeId" runat="server" Text=""></asp:Label></td>     
                </tr>
                <tr>
                    <td align="right" valign="top" nowrap>请输入关联<%=showinfo %>Id</td>
                    <td>
                        <input type="text" id="LinkedId" runat="server" name="LinkedId" size="60" value="">&nbsp;<a href="javascript:void(0)" onclick="AddLinkId()">添加</a>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top"></td>
                    <td id="linklist">
                        <asp:Literal ID="litLinklist" runat="server"></asp:Literal>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <script type="text/javascript">
        function AddLinkId()
        {
            var shoeid = $("#lblshoeId").html();
            var linktype = $("#linktype").val();
            var linkid = $("#LinkedId").val();
            var postdata = { shoeid: shoeid, linktype: linktype, linkid: linkid, action: "add" }
            $.post("/Admin/ShoesLinkEdit.aspx", postdata, function (data) {
                var jsondata = JSON.parse(data)
                if (jsondata.status == 1) {
                    if (jsondata.linktype == 1) {
                        $("#linklist").prepend("<div id=" + jsondata.id + " ><a id=" + jsondata.id + " href='/blog/" + jsondata.linkedId + ".aspx' target=\"_blank\">" + jsondata.title + "</a>&nbsp;&nbsp;<a href=\"javascript: void(0)\" onclick=\"DelLink(" + jsondata.id + ")\">删除</a></div>");
                    }
                    else if (jsondata.linktype == 2) {
                        $("#linklist").prepend("<div id=" + jsondata.id + " ><a id=" + jsondata.id + " href='/GroupBuy/Group.aspx?id=" + jsondata.linkedId + "' target=\"_blank\">" + jsondata.title + "</a>&nbsp;&nbsp;<a href=\"javascript: void(0)\" onclick=\"DelLink(" + jsondata.id + ")\">删除</a></div>");
                    }
                }
                else {
                    alert(jsondata.msg);
                }
            })
        }
        function DelLink(id) {
            var postdata = { id: id, action: "del" }
            $.post("/Admin/ShoesLinkEdit.aspx", postdata, function (data) {
                var jsondata = JSON.parse(data)
                if (jsondata.status == 1) {
                    alert("删除成功！");
                    $("#" + id).remove();
                }
                else {
                    alert("删除失败! ");
                }
            })
        }
    </script>
</body>
</html>

