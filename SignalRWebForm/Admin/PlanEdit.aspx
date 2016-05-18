<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanEdit.aspx.cs" Inherits="Admin_PlanEdit" %>

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
    table{width: 100%;}
    table tr td:first-child{text-align: right;padding-right: 4px;width: 230px;}
    table ul {margin: 0}
    table ul li{float: left;}
    table ul li input{float: left;}
    table ul li label{float: left;}

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
            font-family: \5FAE\8F6F\96C5\9ED1;
            margin-left:249px;
        }

            .newclub tr td {
                font-size: 12px;
                color: #000;
            }
            /*
            .newclub label {
                margin-bottom: 7px;
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
            }*/

        #idCity, #cCityname {
            display: none;
        }
       
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
		<a href="/" >首页</a>  >
<a href="/Admin/">管理首页</a>><a href="/Admin/Plan.aspx">训练计划</a>>
		编辑
	</div>
      <table>
                    <tr>
                        <td>
                            <label for="">归属</label></td>
                        <td>
                             <asp:DropDownList ID="ddlCode" runat="server"></asp:DropDownList>
                            </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">周</label></td>
                        <td>
                            <input type="text" runat="server" maxlength="2" tabindex="2" id="week" name="week"/>
                            </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">日</label></td>
                        <td>
                            <input type="text" runat="server" maxlength="1" tabindex="3" id="day" name="day"/>
                            </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">说明</label></td>
                        <td>
                            <input type="text" name="memo" id="memo" tabindex="7" runat="server"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">类型</label></td>
                        <td>
                            <em><asp:RadioButtonList ID="rbType" runat="server" RepeatLayout="UnorderedList"  tabindex="3">                               
                                <asp:ListItem Value="1">时间</asp:ListItem>
                                <asp:ListItem Value="2">间歇</asp:ListItem>
                                <asp:ListItem Value="3">休息</asp:ListItem>
                                <asp:ListItem Value="4">比赛</asp:ListItem>
                            </asp:RadioButtonList></em></td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">时间</label></td>
                        <td>
                            <input type="text" name="time" id="time" value="" tabindex="13" runat="server" maxlength="3"/>
                       </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">强度</label></td>
                        <td>
                        <em><asp:RadioButtonList ID="rbStrong" runat="server" RepeatLayout="UnorderedList"  tabindex="3">                               
                                <asp:ListItem Value="1">GR</asp:ListItem>
                                <asp:ListItem Value="2">GE</asp:ListItem>
                                <asp:ListItem Value="3">OR</asp:ListItem>
                                <asp:ListItem Value="4">RO</asp:ListItem>
                            </asp:RadioButtonList></em></td>
                    </tr>
             <tr>
                        <td>
                            <label for="">间歇</label></td>
                        <td>
                        <input type="text" name="space" id="space" value="" tabindex="17" runat="server" maxlength="30"/>
                        </td>
                    </tr>
          <tr>
                        <td>
                            <label for="">备注</label></td>
                        <td>
                        <input type="text" name="Mark" id="Mark" value="" tabindex="17" runat="server" maxlength="30" />
                        </td>
                    </tr>
          <tr>
                        <td>
                            <label for="">排序</label></td>
                        <td>
                        <input type="text" name="order" id="order" value="" tabindex="17" runat="server" maxlength="2"/>
                        </td>
                    </tr>
                </table>                
   <div class="indecen">
            <div class="newclub">
                 <asp:Button ID="Button1" runat="server" Text="返回" OnClick="Button1_Click" />                
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/save.png" OnClick="ImageButton1_Click" />
            </div>
        </div>
</div>
</center>
    </form>
</body>
</html>
