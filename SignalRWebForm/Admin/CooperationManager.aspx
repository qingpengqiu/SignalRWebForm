<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CooperationManager.aspx.cs" Inherits="Admin_CooperationManager" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>添加合作客户</title>    
     <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <script src="/Html/js/jquery-1.11.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript">
        <%=exeJs%>
    </script>
</head>
<body>
    <form id="form1" runat="server">
<div style="width:100%;height:85px;padding-top:30px;background-color:#F8FFF8;">
	<div style="width:950px;height:85px;text-align:left;">
		<img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right:80px;">
		<img src="/images/top-user.jpg">
	</div>
</div>
        <table width="100%">
            <tr>
                <td>合作客户：<input type="text" id="txtname" maxlength="20" runat="server" style="width: 80px" />
                </td>

                <td>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button runat="server" ID="btnSearch" Text="搜 索" OnClick="btnSearch_Click" />

                    <input type="button" value="添加合作客户" onclick="document.getElementById('divAdd').style.display = ''" />
                </td>
            </tr>
        </table>
        <div id="divAdd" style="display: none; border: 1px solid; margin: 10px;">
            合作客户：<input type="text" maxlength="20" name="name" style="ime-mode: disabled" />
            合作标记：<input type="text" maxlength="50" name="org" />
            类型：<input type="text" maxlength="50" name="type" />
            <asp:Button runat="server" ID="btnAdd" OnClick="btnAdd_Click" Text="添 加" />
            <input type="button" value="取消" onclick="document.getElementById('divAdd').style.display = 'none'" />
        </div>

        <table width="100%" border="1" style="border-collapse: collapse" cellpadding="2" cellspacing="0">
            <tr>
                <td>合作伙伴</td>
                <td>合作标记</td>
                <td>类型</td>
                <td>创建时间</td>
                <td>操作</td>
            </tr>
            <asp:Literal runat="server" ID="ltlList" />
        </table>
        <table width="100%">
            <tr>
                <td>
                    <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
                        NextPageText="下一页" OnPageChanged="AspNetPager1_PageChanged" PageSize="24" PrevPageText="上一页"
                        ShowPageIndexBox="Always" SubmitButtonText="跳转" AlwaysShow="true">
                    </webdiyer:AspNetPager>
                </td>
            </tr>
        </table>
    </form>
    <script type="text/javascript">
        function UpdateState(obj, id, state) {
            var postdata = { id: id, state: state };
            $.post("/Admin/Ajax/UpdateState.ashx", postdata, function (returnvalue) {
                if (returnvalue == "1") {
                    if (state==0) {
                        $(obj).replaceWith("<a href='javascript:void(0)' onclick='UpdateState(this," + id + ",1)'>启用</a>");
                    }
                    else if (state==1) {
                        $(obj).replaceWith("<a href='javascript:void(0)' onclick='UpdateState(this," + id + ",0)'>禁用</a>");
                    }
                }
            });
        }
    </script>
</body>
</html>
