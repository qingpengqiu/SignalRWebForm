<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExportUpState.aspx.cs" Inherits="Admin_Backstage_ExportUpState" %>

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

    .cont table tr td:last-child input,.cont table tr td:last-child select {
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
</style>
<div class="cont">
	<div class="conttop">
		<a href="/" >首页</a> >
		编辑
	</div>
    
	<table>
		<tr>
			<td><label >赛事名称：</label></td>
			<td>
            <input type="text" id="idcomp" readonly  tabindex="1" runat="server"/>
            </td>
		</tr>
		<tr>
			<td><label>项目名称：</label></td>
			<td>
				<input type="text" id="iditem" readonly  tabindex="1" runat="server"/>	
			</td>
		</tr>
		<tr>
			<td><label >状态：</label></td>
            <td>
                 <select id="iStatus" name="iStatus" runat="server" style="width: 220px;" >                     
                     <%--<option value="0">未审核</option>--%>
                     <option value="1">待付款</option>
                     <option value="2">已付款</option>
                     <%--<option value="3">已组队</option>--%>
                    <option value="-1">已过期</option>
                </select>
            </td>			
		</tr>
<%--        <tr >
            <td><label >审核批注：</label></td>
            <td>
                 <input type="text" id="cMack3"  tabindex="1" runat="server"/>	
            </td>
        </tr>--%>
     <%--   <tr id="sh" style="display:none">
			<td><label >审核：</label></td>
            <td>
                <select id="cMack3" name="iStatus" runat="server" style="width: 220px;">
                     <option value="1">通过</option>
                     <option value="0">不通过</option>
                </select>
            </td>			
		</tr>--%>
          <tr>
        <td colspan="2">
            <asp:Button ID="Btnsubmit" runat="server" Text="Button" OnClick="Btnsubmit_Click"></asp:Button>
        </td>
    </tr>
	</table>
</div>
</center>
        <script type="text/javascript">
            $("#iStatus").change(function(event) {
                var i = $(this).val()
                if (i == -1) {
                    $("#sh").show()
                }else{
                    $("#sh").hide()
                }
            });
            
    </script>
    </form>

</body>
</html>