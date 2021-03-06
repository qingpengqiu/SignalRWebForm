<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventEdit.aspx.cs" Inherits="Admin_EventEdit" %>

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
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
    <link href="/Html/select2/select2.css" rel="stylesheet" />
    <script type="text/javascript" src="/Html/select2/select2.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#DDLRace").select2();
        });

    </script>
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
     
            text-align: center;
          
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
		<a href="/Admin/RaceList.aspx">赛事首页</a> >
<a href="/Admin/Event.aspx">赛事设置列表 </a>>
		赛事设置
	</div>
   <div class="indecen">
            <div class="newclub">
                <table>
                     <tr>
                        <td>
                            <label for="">是否在益跑网有报名</label></td>
                        <td>
                            <asp:RadioButtonList ID="iserun" runat="server" RepeatLayout="UnorderedList" tabindex="3" OnSelectedIndexChanged="iserun_SelectedIndexChanged" AutoPostBack="True">
                            <asp:ListItem Value="1" Selected="True">是</asp:ListItem>
                            <asp:ListItem Value="0">否</asp:ListItem>
                        </asp:RadioButtonList>
                        </td>
                    </tr>           
                     <tr id="dllrun" runat="server" visible="false">
                        <td>
                            <label for="">赛事名称</label></td>
                        <td>
                         <%-- <asp:DropDownList ID="DDLRace" runat="server">
                            </asp:DropDownList>--%>
                            <select id="DDLRace" runat="server" style="width: 200px;" onchange="ForOnChange()"></select>
                        </td>
                    </tr>
                    <tr id="txtrun" runat="server" visible="false">
                        <td>
                            <label for="">赛事名称</label></td>
                        <td>
                            <input type="text" tabindex="2" id="cname" name="name" runat="server" maxlength="64" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">查询方式</label></td>
                        <td>
                            <asp:RadioButtonList ID="rdoEntry" runat="server" RepeatLayout="UnorderedList" tabindex="3">
                            <asp:ListItem Value="1" Selected="True">姓名+证件号码</asp:ListItem>
                            <asp:ListItem Value="2">姓名+参赛号码</asp:ListItem>
                        </asp:RadioButtonList>
                        </td>
                    </tr> 
                     <tr>
                        <td>
                            <label for="">头图</label></td>
                        <td>
                           <asp:FileUpload ID="hdtt" runat="server" class="input-large"/> <asp:Label ID="lbtt" runat="server" Text="" ></asp:Label>
                                    图片大小1M以下，建议分辨率822*166
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">是否有证书</label></td>
                        <td>
                            <asp:RadioButtonList ID="idoc" runat="server" RepeatLayout="UnorderedList" tabindex="3">
                            <asp:ListItem Value="1" Selected="True">是</asp:ListItem>
                            <asp:ListItem Value="0">否</asp:ListItem>
                        </asp:RadioButtonList>
                        </td>
                    </tr>       
                       <tr>
                        <td>
                            <label for="">证书模版</label></td>
                        <td>
                           <asp:FileUpload ID="zsmb" runat="server" class="input-large"/> <asp:Label ID="lbmb" runat="server" Text="" ></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">状态</label></td>
                        <td>
                            <select id="iStatus" runat="server" tabindex="13"> 
                                <option value="1">正常</option>
                                <option value="0">禁用</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">备注</label></td>
                        <td>
                            &nbsp;<asp:TextBox ID="txtMark" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
            </div>
        </div>
</div>
</center>
    </form>
    <script>
        function ForOnChange() {
            var idRace = $("#DDLRace").val();
            window.location.href = "/admin/EventEdit.aspx?id=" + <%=id%> + "&idRace=" + idRace
        }
        </script>
</body>
</html>
