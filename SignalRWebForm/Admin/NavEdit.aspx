<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NavEdit.aspx.cs" Inherits="Admin_NavEdit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理入口-益跑网</title>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Html/js/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Html/js/jCalendar.js"></script>

    <form id="form2" runat="server">
        <center>
<div style="width:100%;height:85px;padding-top:30px;background-color:#F8FFF8;">
    <div style="width:950px;height:85px;text-align:left;">
        <img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right:80px;">
        <img src="/images/top-user.jpg">
    </div>
</div>
<style>
    .cont {
        width: 930px;
        height: 600px;
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

    .cont table {
        color: #666;
        width: 930px;
    }

        .cont table tr td:first-child {
            width: 120px;
            text-align: right;
        }

        .cont table tr td:last-child {
            width: 410px;
        }

        .cont table tr {
            height: 40px;
            line-height: 50px;
        }

    #CalendarDiv select {
        width: 60px;
        height: 20px;
    }

    #CalendarDiv table tr {
        height: 20px;
        line-height: 20px;
    }

        #CalendarDiv table tr td {
            height: 20px;
            line-height: 20px;
        }

    #signingup {
        width: 202px;
    }

    .cont table tr td:last-child input {
        float: left;
        margin-left: 4px;
    }

    .cont table tr td:last-child label {
        float: left;
        margin-left: 3px;
        margin-right: 4px;
    }

    .cont select {
        width: 320px;
    }

    .item {
        width: 124px;
    }

    .price {
        width: 58px;
    }

    .number {
        width: 58px;
    }

    .cont table tr .project label {
        margin-top: 4px;
    }

    .addproject {
        width: 60px;
        height: 22px;
        line-height: 22px;
        color: #458b08;
        font-size: 12px;
        border: 1px solid #e5e5e5;
        text-align: center;
        border-radius: 4px;
        float: left;
    }

    #Btnsubmit {
        width: 83px;
        height: 32px;
        background: url(/Images/submit.gif);
        border: 0;
        text-indent: -999em;
    }

    #tips {
        background: #fff;
        height: 100%;
        line-height: 110px;
        text-align: center;
        font-size: 14px;
    }

        #tips img {
            margin-right: 4px;
        }

    #thumb {
        width: 630px;
        height: 430px;
        background: #fff;
        padding-top: 40px;
    }
    .maxm td{text-align: center!important;}
    .cont table.maxm tr td:last-child{width: auto;}
</style>
<div class="cont">
	<div class="conttop">
		<a href="/" >首页</a>  >
<a href="/Admin/">管理首页</a>><a href="/Admin/NavList.aspx">频道列表</a>>
		发布赛事
	</div>
<table>
    <tr>
                        <td>
                            <label for="">频道名称</label></td>
                        <td>
                            <input type="text" tabindex="1" id="name" name="name" runat="server" maxlength="64" />
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">排序</label></td>
                        <td>
                            <input type="text" tabindex="4" id="iNum" name="name" runat="server" maxlength="512" />
                        </td>
                    </tr>
     <tr>
                        <td>
                            <label for="">显示条数</label></td>
                        <td>
                            <input type="text" tabindex="4" id="maxpage" name="name" runat="server" maxlength="512" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">状态</label></td>
                        <td>
                            <select id="state" runat="server" tabindex="5"> 
                                <option value="1">正常</option> 
                                <option value="0">暂停</option>
                            </select>
                        </td>
                    </tr>
     <tr>
			<td><label>频道分类：</label></td>
			<td>			
                <asp:CheckBoxList ID="cbxClass" runat="server" RepeatColumns="6" RepeatLayout="Flow"></asp:CheckBoxList>	
			</td>
		</tr>
    <tr>
        <td colspan="2">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
        </td>
    </tr>
</table>

    <div style="display:none">
    <div id="tips" >
        
    </div>  
</div>
</div>
</center>
    </form>
</body>
</html>

