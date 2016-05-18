<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RacePrint.aspx.cs" Inherits="Raceresult_RacePrint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>证书打印-益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <iframe src="<%=FilePath %>" frameborder="0" width="100%" height="600px"></iframe>
        </div>
    </form>
</body>
</html>
