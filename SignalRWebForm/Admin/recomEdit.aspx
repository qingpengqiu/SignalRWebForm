<%@ Page Language="C#" AutoEventWireup="true" CodeFile="recomEdit.aspx.cs" Inherits="Admin_recomEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>�������-������</title>
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
            font-family: ΢���ź�;
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
		<a href="/">��ҳ</a> >
<a href="/admin/">������ҳ</a> > 
		�༭�Ƽ�
	</div>
   <div class="indecen">
            <div class="newclub">
                <table>
                    <tr>
                        <td>
                            <label for="">�û�id</label></td>
                        <td>
                            <input type="text" tabindex="1" id="name" name="name" runat="server" maxlength="9" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">���</label></td>
                        <td>
                            <textarea id="Idmsg" cols="20" rows="2" runat="server" maxlength="128"></textarea>
                            <input type="text" id="b2" readonly="readonly" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">����</label></td>
                        <td>
                            <select id="Style" runat="server">
                                <option value="0">��ѡ��</option>
                                <option value="1">��Լר��</option>
                                <option value="2">��������</option> 
                                <option value="3">��������</option>
                                <option value="4">��������</option>
                            </select>
                        </td>
                    </tr>
                    <%--<tr>
                        <td>
                            <label for="">״̬</label></td>
                        <td>
                            <select id="state" runat="server">                                
                                <option value="1">����</option>
                                <option value="-1">ɾ��</option>                                
                            </select>
                        </td>
                    </tr>         --%>          
                </table>
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
            </div>
        </div>
</div>
</center>
    </form>

</body>
</html>

