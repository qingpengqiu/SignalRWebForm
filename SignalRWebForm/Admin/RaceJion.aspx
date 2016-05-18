<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceJion.aspx.cs" Inherits="Admin_RaceJion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>�������-������</title>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
     <link href="/Html/select2/select2.css" rel="stylesheet" />
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/select2/select2.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#DDLRace").select2();
        });

    </script>
</head>

<body>
    <form id="form1" runat="server">
        <center>           
        <div style="width: 100%; height: 85px; padding-top: 30px; background-color: #F8FFF8;">
            <div style="width: 950px; height: 85px; text-align: left;">
                <img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right: 80px;">
                <img src="/images/top-user.jpg">
            </div>
        </div>
     
            <style>
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

            .gtable {
                width: 1700px;
                overflow: auto;
            }

            body .auditclub tr:first-child td {
                font-size: 16px;
                color: #637496;
            }

            .auditclub {
                /* width: 100%;
                padding-left: 200px;*/
            }

                .auditclub table {
                    width: 100%;
                    text-align: center;
                }

                    .auditclub table tr {
                        height: 36px;
                        line-height: 36px;
                    }

            .auditclubs table {
                width: 800px;
            }

                .auditclubs table tr td:first-child {
                    width: 240px;
                    text-align: right;
                    padding-right: 10px;
                    color: #000;
                    font-weight: bold;
                }

                .auditclubs table tr {
                    height: 42px;
                }

            .auditclubs select {
                margin-bottom: 0;
            }

            .auditclubs table tr td.shcz {
                text-align: center;
                padding-top: 30px;
            }

            #bohuibox {
                width: 100%;
                height: 100%;
                background: #fff;
            }

                #bohuibox h2 {
                    color: #077fc6;
                    font-weight: bold;
                    font-size: 16px;
                    margin: 0;
                    padding-left: 18px;
                    line-height: 56px;
                }

                #bohuibox textarea {
                    font-size: 14px;
                    height: 140px;
                    margin-left: 20px;
                    padding: 2px;
                    width: 426px;
                }
                .tnewuser{float: right;color: #f00}
        </style>
        <div class="cont">
            <div class="conttop">
		<a href="/" >��ҳ</a>  >
<a href="/Admin/RaceList.aspx">������ҳ</a>>
		������Ϣ�鿴
	</div>
            <table style="width:100%">
		<tr>
			<td>ѡ�����£�<%--<asp:DropDownList ID="DDLRace" runat="server" OnSelectedIndexChanged="DDLRace_SelectedIndexChanged"  AutoPostBack="true">
                </asp:DropDownList>--%><select id="DDLRace" runat="server" style="width: 200px;" onchange="ForOnChange()"></select>
            </td>           
		</tr>
                <tr>
                    <td>
                       <asp:RadioButtonList ID="rblFromTpye" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rblFromTpye_SelectedIndexChanged">
                        <asp:ListItem Value="2">����</asp:ListItem>
                        <asp:ListItem Value="4">�Ƶ�</asp:ListItem>
                        <asp:ListItem Value="5" >����</asp:ListItem>
                        <asp:ListItem Value="8">װ��</asp:ListItem>
                        <asp:ListItem Value="9" >������</asp:ListItem>
                        </asp:RadioButtonList>
                        </td>
                </tr>
		<tr>
			<td>
                <asp:RadioButtonList ID="rblItem" runat="server" OnSelectedIndexChanged="rblItem_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" ></asp:RadioButtonList>
                <asp:RadioButtonList ID="rblitemSmall" runat="server" OnSelectedIndexChanged="rblitemSmall_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" ></asp:RadioButtonList>
                <asp:Button ID="btnExecl" runat="server" Text="�����û���Ϣ" OnClick="btnExecl_Click" />
                <asp:Button ID="btnAllEcexl" runat="server" Text="����������Ϣ" OnClick="btnAllEcexl_Click" />
            </td>
		</tr>
	</table>
            </div>
           <div class="auditclub">
                <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <td>���</td>
                            <td>״̬</td>
                            <td>��Դ</td>
                            <td>��Ŀ</td>
                            <td>����</td>
                            <td>�ǳ�</td>
                            <asp:Literal ID="ltlNav" runat="server"></asp:Literal>                            
                            <td>�����ע</td>                            
                            <td>����</td>
                            <td>����</td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <a name='a<%# Eval("id")%>'></a>
                            <%# Container.ItemIndex + 1%>
                        </td>                         
                        <td><%# Eval("iStatus").ToString() == "0" ? "<font color=\"#B23AEE\">�����</font>" : Eval("iStatus").ToString() == "1"?"<font color=\"#B23AEE\">δ����</font>":Eval("iStatus").ToString() == "2" ? "<font color=\"#008800\">�Ѹ���</font>":Eval("iStatus").ToString() == "3" ? "<font color=\"#008800\">�����</font>":"<font color=\"#FF0000\">�ѹ���</font>"%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cFrom")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cItemName")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iBuyNum")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cNickName")%></td>
                        <%#GetBMinfo(Eval("ID").ToString()) %>                       
                         
                          <td><%# DataBinder.Eval(Container.DataItem, "cMake3")%></td>
                        <td><%#GetUserInfo(Eval("ID").ToString()) %></td>
                        <td><%# Eval("iScore").ToString() == "0" ? "��" :"��"%></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr bgcolor="#e8e8e8">
                        <td>
                            <a name='a<%# Eval("id")%>'></a>
                            <%# Container.ItemIndex + 1%>
                        </td>                        
                        <td><%# Eval("iStatus").ToString() == "0" ? "<font color=\"#B23AEE\">�����</font>" : Eval("iStatus").ToString() == "1"?"<font color=\"#B23AEE\">δ����</font>":Eval("iStatus").ToString() == "2" ? "<font color=\"#008800\">�Ѹ���</font>":Eval("iStatus").ToString() == "3" ? "<font color=\"#008800\">�����</font>":"<font color=\"#FF0000\">�ѹ���</font>"%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cFrom")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cItemName")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iBuyNum")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cNickName")%></td>
                       <%#GetBMinfo(Eval("ID").ToString()) %>
                        
                          <td><%# DataBinder.Eval(Container.DataItem, "cMake3")%></td>
                        <td><%#GetUserInfo(Eval("ID").ToString()) %></td>
                        <td><%# Eval("iScore").ToString() == "0" ? "��" :"��"%></td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater> 
            </div>
             </center>
        <script>
            function ForOnChange() {
                var Idrace = $("#DDLRace").val();
                window.location.href = "/Admin/RaceJion.aspx?idRace=" + Idrace + "&iFromTpye=2"

            }
        </script>
    </form>
</body>
</html>

