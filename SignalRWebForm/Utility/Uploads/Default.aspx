<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Utility_Uploads_Default" %>
<html>
<head>
<title>UPLOAD</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta name="generator" content="yipao editor">
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
</head>
<body>
<form id="form1" runat="server"> 
<center>
<br>
<table width="800" style="padding:8px;line-height:24px;text-align:left;" cellpadding="0" cellspacing="0"> 
<tr> 
	<td align="right"></td> 
	<td>
	</td> 
</tr> 
<tr> 
	<td align="right"></td> 
	<td>
		<asp:FileUpload ID="FileUpload" size="60" runat="server" />
	</td> 
</tr> 
<tr> 
	<td align="right"></td> 
	<td><asp:Button ID="Button2" runat="server" Text="Upload..." Width="88px" /></td> 
</tr> 
<tr> 
	<td align="right"></td> 
	<td>
	</td> 
</tr> 
</table> 
</center>
</form>
</body>
</html>
