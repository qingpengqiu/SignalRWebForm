<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CodeList.aspx.cs" Inherits="Admin_CodeList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理入口-益跑网</title>
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
    <style type="text/css">
        .cont {
            width: 930px;
            padding: 10px;
            text-align: left;
            font-family: 微软雅黑;
        }

        .conttop {
            padding: 10px;
            height: 32px;
            font-size: 14px;
            font-weight: bold;
            color: #333;
        }

        .newclub {
            width: 100%;
            overflow: hidden;
            margin-top: 70px;
            font-family: \5FAE\8F6F\96C5\9ED1;
        }

            .newclub tr td {
                font-size: 14px;
                color: #000;
                height: 30px;
            }

                .newclub tr td:first-child {
                    width: 260px;
                    text-align: right;
                }

            .newclub label {
                margin-bottom: 0px;
                padding-right: 10px;
                display: inline-block;
            }

            .newclub select {
                width: 120px;
            }

            .newclub textarea {
                padding: 14px;
                width: 420px;
                height: 120px;
            }

        #idCity, #cCityname {
            display: none;
        }

        #b2 {
            border: 0px;
            background: none;
            box-shadow: none;
            font-size: 12px;
            margin: -10px 0 0 320px;
        }

            #b2:focus {
                box-shadow: none;
            }

        .newclub li {
            float: left;
            width: 154px;
            text-align: center;
            height: 152px;
        }

        .newclub ul {
            width: 464px;
            display: inline-block;
            padding-top: 20px;
        }

            .newclub ul label {
                margin: 0;
            }

        #ImageButton1 {
            margin: 40px auto;
            display: block;
        }
        #btCode,#btUse{background: #fff;border: 1px solid #999;width: 80px;border-radius: 3px;margin-top: -10px;height: 30px;margin-left: 6px;}
        #btCode:hover,#btUse:hover{background: #eee}
        #btUse{margin-left: 0;margin-top: 4px;}
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <center>
<div style="width:100%;height:85px;padding-top:30px;background-color:#F8FFF8;">
	<div style="width:950px;height:85px;text-align:left;">
		<img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right:80px;">
		<img src="/images/top-user.jpg">
	</div>
</div>

<div class="cont">
	<div class="conttop">
		<a href="/">首页</a> >
        <a href="/Admin/PayList.aspx">物品管理首页</a>>
		 兑换码操作
	</div>
   <div class="indecen">
            <div class="newclub">
                <table>
                    <tr>
                        <td>
                            <label for="txtUserId">兑换码:</label></td>
                        <td>
                            <input type="text" tabindex="1" id="tbCode" name="name" runat="server" maxlength="64" />
                        </td>
                        <td>
                            <asp:Button ID="btCode" runat="server" OnClick="btCode_Click" Text="查询" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>物品名称:</label></td>
                        <td>
                            <asp:Label ID="lbGood" runat="server"></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">价值:</label></td>
                        <td>
                            <asp:Label ID="lbValue" runat="server"></asp:Label>
                         </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">是否有效:</label></td>
                        <td>
                            <asp:Label ID="lbValid" runat="server"></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">有效期:</label></td>
                        <td>
                            <asp:Label ID="lbdValid" runat="server"></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">是否使用:</label></td>
                        <td>
                            <asp:Label ID="lbUse" runat="server"></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:HiddenField ID="hfId" runat="server"></asp:HiddenField></td>
                        <td>
                            <asp:Button ID="btUse" runat="server" OnClick="btUse_Click" Text="使用" />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>                       
                </table>
            </div>
        </div>
</div>
</center>
    </form>

</body>

</html>
