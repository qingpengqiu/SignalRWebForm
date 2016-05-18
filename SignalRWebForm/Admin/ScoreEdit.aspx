<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ScoreEdit.aspx.cs" Inherits="Admin_ScoreEdit" %>

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
            margin-top: 10px;
            font-family: \5FAE\8F6F\96C5\9ED1;
        }

            .newclub tr td {
                font-size: 14px;
                color: #000;
            }

                .newclub tr td:first-child {
                    width: 260px;
                    text-align: right;
                }

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
		<a href="/Admin/">管理首页</a> >
<a href="/Admin/ScoreList.aspx">积分管理</a>>
		编辑积分设置
	</div>
 <div class="newclub">
                <table>
                    <tr>
                        <td>
                            积分分类</td>
                        <td>
                            <asp:DropDownList ID="ddlType" runat="server">
                                <asp:ListItem Value="1">固定积分</asp:ListItem>
                                <asp:ListItem Value="2">购买行为</asp:ListItem>
                                <asp:ListItem Value="3">手动操作</asp:ListItem>
                                <asp:ListItem Value="4">兑换行为</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">积分编码</label></td>
                        <td>
                            <input type="text" tabindex="1" id="idCode" name="idCode" runat="server" readonly />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">积分名称</label></td>
                        <td>
                            <input type="text" tabindex="1" id="ChildTypeName" name="ChildTypeName" runat="server" maxlength="128" />
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">积分分值</label></td>
                        <td>
                            <input type="text" tabindex="4" id="fScore" name="fScore" runat="server" maxlength="5" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">每日频率</label></td>
                        <td>
                            <input type="text" tabindex="4" id="iCycle" name="iCycle" runat="server" maxlength="5" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">积分总次数</label></td>
                        <td>
                            <input type="text" tabindex="4" id="iTotal" name="iTotal" runat="server" maxlength="5" />
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">积分区间</label></td>
                        <td>
                            <input type="text" tabindex="4" id="iMax" name="iMax" runat="server" maxlength="8" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">积分描述</label></td>
                        <td>
                            <input type="text" tabindex="4" id="cDescription" name="cDescription" runat="server" maxlength="256" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">状态</label></td>
                        <td>
                            <select id="state" runat="server" tabindex="5"> 
                                <option value="1">正常</option> 
                                <option value="0">禁用</option>                                                               
                            </select>
                        </td>
                    </tr>                   
                </table>
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
            </div>
</div>
</center>
    </form>

</body>
</html>