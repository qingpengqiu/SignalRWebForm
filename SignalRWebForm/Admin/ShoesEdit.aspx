<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoesEdit.aspx.cs" Inherits="Admin_ShoesEdit" %>

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
		<a href="/Admin/ShoesList.aspx" >首页</a> >
		发布跑鞋
	</div>
    <table>
		<tr>
			<td><label for="name">名称：</label></td>
			<td>
                <input type="text" id="mc" tabindex="1" runat="server" maxlength="128"/>	
			</td>
			<td>
               <label for="item">性别</label></td>
			<td>
                <asp:RadioButtonList ID="xb" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="2">
                    <asp:ListItem Value="0">男性</asp:ListItem>
                    <asp:ListItem Value="1" Selected="True">女性</asp:ListItem>
                    <asp:ListItem Value="2" Selected="True">中性</asp:ListItem>
                </asp:RadioButtonList>
                </td>
			<td><label for="item">品牌</label></td>
			<td>
               <input type="text" id="pp" class="item"  runat="server" tabindex="3" maxlength="64" />
			</td>
		</tr>	
        <tr>			
			<td><label for="item">系列</label></td>
			<td>
               <input type="text" id="xl" class="item"  runat="server" tabindex="4" maxlength="64" />
			</td>
			
            <td><label for="item">售价</label></td>
			<td>
               <input type="text" class="price"  id="sj"  runat="server" tabindex="5" maxlength="9" /><label for="price">元</label>
			</td>
            <td><label for="item">类型</label></td>
			<td>             
                <select id="ShoeType" tabindex="5" runat="server">
                <option value="公路">公路</option>
                <option value="越野">越野</option>
                </select>
                <%--<input type="text" id="lx" class="item"  runat="server" tabindex="6" maxlength="64" />--%>
			</td>
		</tr>
        <tr>
            <td><label for="number">特点</label></td>
			<td>
              <input type="text" id="td" runat="server" class="number" tabindex="7" maxlength="64" />
			</td>
			<td><label for="item">重量</label></td>
			<td>
               <input type="text" id="zl" class="item"  runat="server" tabindex="8" maxlength="6" />
			</td>
            <td><label for="commemt">后跟高</label></td>
			<td>
               <input type="text" class="hgg" id="hgg" runat="server" tabindex='9' maxlength="6" />
			</td>           
		</tr>
        <tr>
			 <td><label for="item">前跟高</label></td>
			<td>
               <input type="text" id="qgg" class="item"  runat="server" tabindex="10" maxlength="6" />
			</td>			
            <td><label for="item">图片链接</label></td>
			<td>
                <asp:FileUpload ID="FileUpload1" runat="server" />
&nbsp;<asp:Label ID="fileurl" runat="server"></asp:Label>
             </td>
            <td><label for="item">特别荣誉</label></td>
			<td>
               <input type="text" id="tbry" class="item"  runat="server" tabindex="12" maxlength="64" />
			</td>
		</tr>
        <tr>
			
            <td><label for="item">要点</label></td>
			<td>
               <input type="text" id="yd" class="item"  runat="server" tabindex="13" maxlength="128" />
			</td>
            <td><label for="item">点评</label></td>
			<td>
               <input type="text" id="dp" class="item"  runat="server" tabindex="14" maxlength="1000" />
			</td>
            <td><label for="item">评测</label></td>
			<td>
               <input type="text" id="pc" class="item"  runat="server" tabindex="15" maxlength="1000" />
			</td>
		</tr>
		<tr>
			
			<td><label for="item">上市时间</label></td>
			<td>
                 <%--<input id="sssj" runat="server" name="dRaceBegin" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd',minDate:'%y-%M-#{%d}'})" />--%>
                  <input type="text" id="sssj" class="item"  runat="server" tabindex="16" />
			</td>
            <td><label for="item">视频链接</label></td>
			<td>
               <input type="text" id="splj" class="item"  runat="server" tabindex="17" maxlength="256" />
			</td>
            <td></td>
			<td>
              
			</td>
		</tr>	  
        <tr>
            <td><label for="item">V重量</label></td>
			<td>
               <input type="text" id="vzl" class="item"  runat="server" tabindex="18" maxlength="3" />
			</td>
			<td><label for="item">V高度</label></td>
			<td>
               <input type="text" id="vgd" class="item"  runat="server" tabindex="19" maxlength="3" />
			</td>
			<td><label for="item">V后跟减震</label></td>
			<td>
               <input type="text" id="vhgjz" class="item"  runat="server" tabindex="20" maxlength="3" />
			</td>
		</tr>
        <tr>
			<td><label for="item">V前脚掌减震</label></td>
			<td>
               <input type="text" id="vqjzjz" class="item"  runat="server" tabindex="21" maxlength="3" />
			</td>
			<td><label for="item">V硬度</label></td>
			<td>
               <input type="text" id="vyd" class="item"  runat="server" tabindex="22" maxlength="3" />
			</td>
            	<td><label for="item">V稳定性</label></td>
			<td>
               <input type="text" id="vwdx" class="item"  runat="server" tabindex="23" maxlength="3" />
			</td>
		</tr>
       
        <tr>
			<td></td>
			<td>
			</td>
			<td>
			   <asp:Button ID="Btnsubmit" runat="server" Text="Button" OnClick="Btnsubmit_Click"></asp:Button></td>
			<td>
			    &nbsp;</td>
            <td></td>
			<td></td>
		</tr>
	</table> 
</div>
</center>
    </form>
</body>
</html>
