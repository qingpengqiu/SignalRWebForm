<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Shoesdr.aspx.cs" Inherits="Admin_Shoesdr" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>    
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<body>
    <form id="form1" runat="server">
   <div>  
        <asp:FileUpload ID="FileUpload1" runat="server" /> 
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />  
    </div>  
    </form>
</body>
</html>
