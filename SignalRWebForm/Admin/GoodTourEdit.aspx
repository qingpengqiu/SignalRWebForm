<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GoodTourEdit.aspx.cs" Inherits="Admin_GoodTourEdit" %>
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
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
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
		<a href="/Admin/PayList.aspx">��Ʒ������ҳ</a> >
<a href="/Admin/GoodList.aspx">��Ʒ�б�</a>>
		�༭��Ʒ
	</div>
   <div class="indecen">
            <div class="newclub">
                <table>
                     <tr>
                        <td>
                            <label for="">��Ʒ���</label></td>
                        <td>
                            <select id="itpye" runat="server" tabindex="5" disabled> 
                                <option value="1">���ֶһ�</option>
                                <option value="2"  selected="selected">�Ź���Ʒ</option>
                                <%--<option value="3">��ͨ��Ʒ</option>--%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">��Ʒ����</label></td>
                        <td>
                            <input type="text" tabindex="1" id="cname" name="name" runat="server" maxlength="64" />
                        </td>
                        
                    </tr>
                    <tr>
                        <td>
                            <label for="">��Ʒ����</label></td>
                        <td>
                            <select id="splx" runat="server"> 
                                <option value="0">����</option>
                                <option value="1">װ��</option>
                                <option value="2">�Ƶ�</option>
                                <option value="3">Ӫ��Ʒ</option>
                                <option value="4">���Ӳ�Ʒ</option>
                                <option value="5">���·���</option>
                                 <option value="6">��ѵ�γ�</option>
                                <%--<option value="3">��ͨ��Ʒ</option>--%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">��Ʒ����</label></td>
                        <td>
                            <asp:RadioButtonList ID="rdoEntry" runat="server" RepeatLayout="UnorderedList" tabindex="2">
                            <asp:ListItem Value="0" Selected="True">����</asp:ListItem>
                            <asp:ListItem Value="1">ʵ��</asp:ListItem>
                        </asp:RadioButtonList>
                        </td>
                    </tr>                    
                    <tr>
                        <td>
                            <label for="">�ϼ�ʱ��</label></td>
                        <td>
                           <input id="dbegintime" runat="server" class="Wdate" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'dendtime\')}'})"/>-<input id="dendtime" runat="server" class="Wdate" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'dbegintime\')}'})"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">�г��۸�</label></td>
                        <td>
                            <input type="text" runat="server" tabindex="4" id="fMarketPrice" maxlength="5" /><label for="">Ԫ</label>
                        </td>
                    </tr>                   
                     <tr>
                        <td>
                            <label for="">ʹ�û���</label></td>
                        <td>
                            <asp:RadioButtonList ID="rdoScore" runat="server" RepeatLayout="UnorderedList" tabindex="2" OnSelectedIndexChanged="rdoScore_SelectedIndexChanged" AutoPostBack="True">
                                <asp:ListItem Value="1">��</asp:ListItem>
                                <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                     <tr id="jfdh" runat="server" visible="false">
                        <td>
                            <label for="">���ֶһ�</label></td>
                        <td>
                           <label for="iScore">����Ʒ����</label><input type="text" name="iScore" id="iScore" runat="server" class="number" tabindex="12" value="0" style="width: 40px" /><label for="iMoney">���ֶһ�</label><input type="text" name="iMoney" id="iMoney" runat="server" class="number" tabindex="13" value="0" style="width: 40px"/><label for="idNumber">Ԫ</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">ƴ������</label></td>
                        <td>
                            <input type="text" tabindex="4" id="iTourNum" name="name" runat="server" maxlength="10" /><label for="">��</label>��Ĭ��ƴ���������ܳ���5��(û�˹���ʱ����ʾ��)��
                        </td>
                    </tr>
                      <tr>
                        <td>
                            <label for="">������</label></td>
                        <td>
                            <input type="text" tabindex="4" id="iQuantity" name="name" runat="server" maxlength="10" /><label for="">��</label>��ÿ���û����������
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">��ƷͼƬ</label></td>
                        <td>
                           <asp:FileUpload ID="hdtt" runat="server" class="input-large"/> <asp:Label ID="lbtt" runat="server" Text="" ></asp:Label>
                                    ͼƬ��С1M���£�����ֱ���300*300
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">�ⲿ����</label></td>
                        <td>
                            <input type="text" tabindex="4" id="cLink" name="name" runat="server" maxlength="512" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">��Ʒ����</label></td>
                        <td><%--<textarea id="cBio" runat="server" rows="2" cols="20"></textarea>--%>
                            <textarea name="cBio" id="cBio" runat="server"  rows="2" cols="20"></textarea>

                        <script src="../UEditor/ueditor-small.config.js"></script>
                        <script src="../UEditor/ueditor.all.js"></script>

                        <script type="text/javascript">
                            var editor = new UE.ui.Editor();
                            editor.render("cBio");
                        </script>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">������</label></td>
                        <td><textarea id="cNorm" name="cNorm" runat="server" rows="2" cols="20"></textarea>
                              <script type="text/javascript">
                                  var editor = new UE.ui.Editor();
                                  editor.render("cNorm");
                        </script>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">״̬</label></td>
                        <td>
                            <select id="state" runat="server" tabindex="5"> 
                                <option value="0">������</option> 
                                <option value="1">����</option>
                                <option value="-1">����</option>
                            </select>
                        </td>
                    </tr>                   
                </table>
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
            </div>
        </div>
</div>
</center>
    </form>

</body>
</html>
