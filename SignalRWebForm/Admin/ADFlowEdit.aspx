<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ADFlowEdit.aspx.cs" Inherits="Admin_ADFlowEdit" %>

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
		<a href="/">首页</a> >
<a href="/admin/">管理首页</a> ><a href="/admin/ADFlow.aspx">流广告</a> > 
		编辑广告
	</div>
   <div class="indecen">
            <div class="newclub">
                <table>
                     <tr>
                        <td>
                            <label for="">类别</label></td>
                        <td>
                            <asp:DropDownList ID="ddltype" runat="server" OnSelectedIndexChanged="ddltype_SelectedIndexChanged" AutoPostBack="True">
                                <asp:ListItem Value="1">图片</asp:ListItem>
                                <asp:ListItem Value="2">flash</asp:ListItem>
                                <asp:ListItem Value="3">html</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>  
                    <tr>
                        <td>
                            <label for="">名称</label></td>
                        <td>
                            <input type="text" tabindex="2" id="name" name="name" runat="server" maxlength="64" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">频道</label></td>
                        <td>
                            <asp:DropDownList ID="ddlChannel" runat="server"></asp:DropDownList> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">页码</label></td>
                        <td>
                           <input type="text" tabindex="4" id="ipage" name="ipage" runat="server" maxlength="3" />（取值范围1-999）
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">插入位置</label></td>
                        <td>
                            <input type="text" tabindex="5" id="iindex" name="iindex" runat="server" maxlength="2" />(取值范围0-19)
                        </td>
                    </tr>
                    <tr id="idImg" runat="server">
                        <td>
                            <label for="">插入图片</label></td>
                        <td>
                              <input type="file" class="input-large fileupload"/><input type="text" id="imgurl" name="imgurl" runat="server"/>
                        </td>
                    </tr>
                    <tr id="idLink" runat="server">
                        <td>
                            <label for="">插入链接</label></td>
                        <td>
                          <input type="text" id="linkurl" name="linkurl" runat="server"/>
                        </td>
                    </tr>
                   <tr>
                        <td>
                            <label for="">html</label></td>
                        <td>
                            <asp:Literal ID="ltlHtml" runat="server"></asp:Literal>
                            <asp:TextBox ID="chtml" runat="server" TextMode="MultiLine"></asp:TextBox>
                            <asp:HiddenField ID="hidhtml" runat="server"></asp:HiddenField>
                        </td>
                    </tr> 
                    <tr>
                        <td>
                            <label for="">开始时间</label></td>
                        <td>
                            <input id="dbegin" runat="server" name="dbegin" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm'})" />
                          
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">结束时间</label></td>
                        <td>
                             <input id="dend" runat="server" name="dend" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm'})" />
                           
                        </td>
                    </tr>   
                     <tr>
                        <td>
                            <label for="">显示设备</label></td>
                        <td>
                             <asp:DropDownList ID="shebei" runat="server">
                                <asp:ListItem Value="0">全部</asp:ListItem>
                                <asp:ListItem Value="1">电脑</asp:ListItem>
                                <asp:ListItem Value="2">手机</asp:ListItem>
                            </asp:DropDownList>
                           <%-- <select id="shebei" runat="server">                                
                                <option value="0">全部</option>
                                <option value="1">电脑</option>  
                                <option value="2">手机</option>                              
                            </select>--%>
                        </td>
                    </tr>                
                </table>
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
            </div>
        </div>
</div>
</center>
    </form>
    <script type="text/javascript">
        $(".fileupload").change(function () {
            var data = new FormData(),
               sthis = $(this)
            $.each(sthis[0].files, function (i, file) {
                data.append('upload_file', file);
            });
            $.ajax({
                url: '/action/fileUp.ashx?name=ADFlow',
                type: 'POST',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    var data = data[0]
                    if (data.status == 1) {
                        sthis.next("input").val(data.url)
                        $(".toast").html(data.message).show().addClass('toast-success')
                        //errorboxhide()

                    } else {
                        $(".toast").html(data.message).show().addClass('toast-error')
                        //errorboxhide()
                    }
                }
            });
        });
    </script>
</body>
</html>
