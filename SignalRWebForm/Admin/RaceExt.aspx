<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceExt.aspx.cs" Inherits="Admin_RaceExt" %>

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

    <form id="form1" runat="server">
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
        width: 80px;
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

    .maxm td {
        text-align: center!important;
    }

    .cont table.maxm tr td:last-child {
        width: auto;
    }
</style>
<div class="cont">
	<div class="conttop">
		<a href="/" >首页</a>  >
<a href="/Admin/RaceList.aspx">赛事首页</a>>
		<a href="/Admin/RaceCom.aspx?id=<%=idCompete %>">发布赛事</a>>添加扩展字段
	</div>
<table>
    <tr>
			<td><label for="ssname">赛事名称：</label></td>
			<td>
                <input type="text" id="ssmc" readonly  tabindex="1" runat="server"/>	
			</td>
		</tr>
    <tr>
			<td><label for="item">项目名称</label></td>
			<td>
               <input type="text" id="item" class="item" readonly runat="server" tabindex="2"/>
			</td>
		</tr>
    <tr>
		<td><label>扩展类型：</label></td>
		<td>			
            <asp:DropDownList ID="ddlType" runat="server" TabIndex="3">                       
                        <asp:ListItem Value="1" Selected="True">附件上传</asp:ListItem>
                        <asp:ListItem Value="2">文本备注</asp:ListItem>
                        <asp:ListItem Value="3">选择项</asp:ListItem>
                    </asp:DropDownList>  
		</td>
	</tr>
    <tr>
		<td><label>中文扩展说明：</label></td>
		<td>			
            <input type="text" id="cnName" class="item"  runat="server" tabindex="4" maxlength="32" />   
		</td>
	</tr>
    <tr>
        <td>
            <label>英文扩展说明：</label>
        </td>
        <td>
                <input type="text" id="enName" class="item"  runat="server" tabindex="5" maxlength="32" /> 
        </td>
    </tr>
     <tr>
		<td><label>存放位置：</label></td>
		<td>			
            <asp:DropDownList ID="ddlfield" runat="server" TabIndex="6">                       
                        <asp:ListItem Value="cRemark2" Selected="True">位置1</asp:ListItem>
                        <asp:ListItem Value="cRemark3">位置2</asp:ListItem>
                        <asp:ListItem Value="cRemark4">位置3</asp:ListItem>
                    </asp:DropDownList>  
		</td>
	</tr>
    <tr>
        <td>
            <label>中文备注：</label>
        </td>
        <td>
                <input type="text" id="tipcnName" class="item"  runat="server" tabindex="7" maxlength="25" /> 
        </td>
    </tr>
    <tr>
        <td>
            <label>英文备注：</label>
        </td>
        <td>
                <input type="text" id="tipenName" class="item"  runat="server" tabindex="8" maxlength="25" /> 
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:Button ID="Btnsubmit" runat="server" Text="Button" OnClick="Btnsubmit_Click"></asp:Button>
        </td>
    </tr>
</table>
</div>
</center>
    </form>
</body>
</html>
