<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sendSMS.aspx.cs" Inherits="sendSMS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" Text="手机号码"></asp:Label>
        <asp:TextBox ID="txtNum" runat="server" TextMode="MultiLine" Height="78px" Width="345px"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="发送内容"></asp:Label>
        <asp:TextBox ID="txtcom" runat="server" TextMode="MultiLine" Height="213px" Width="350px"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="发送" />
        <asp:Label ID="Label3" runat="server" Text="发送状态"></asp:Label><asp:Label ID="lbstate" runat="server" Text="Label"></asp:Label>
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="群发测试" />
         <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="长短信群发测试" />
    </div>
    </form>
</body>
</html>
