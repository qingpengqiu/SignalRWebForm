<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExportOrders.aspx.cs" Inherits="Admin_Backstage_ExportOrders" %>

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
    <script src="/Html/select2/select2.min.js"></script>
  
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
                        
                    <asp:RadioButtonList ID="rdbid" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbid_Selected">
                        <asp:ListItem Value="2" >����</asp:ListItem>
                        <asp:ListItem Value="4">�Ƶ�</asp:ListItem>
                        <asp:ListItem Value="5" >����</asp:ListItem>
                        <asp:ListItem Value="8">װ��</asp:ListItem>
                        <asp:ListItem Value="9" >������</asp:ListItem>
                        </asp:RadioButtonList>
                        <%--<select id="iType" name="iType" runat="server" style="width: 200px;">
                                                <option value="3" >������</option>
                                                <option value="1" selected>����</option>
                                                <option value="2">�Ƶ�</option>
                                            </select>
<asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>--%>
                        <%--<asp:Button ID="Button2" runat="server" Text="����"  OnClick="Button2_Click"></asp:Button>
                        <asp:Button ID="Button3" runat="server" Text="�Ƶ�"  OnClick="Button3_Click"></asp:Button>
                        <asp:Button ID="Button4" runat="server" Text="������" OnClick="Button4_Click"></asp:Button>--%>
                        </td>
                </tr>
		<tr>
			<td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" Visible="False" ></asp:RadioButtonList>
                <asp:RadioButtonList ID="jdradio" runat="server" OnSelectedIndexChanged="jdradio_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" ></asp:RadioButtonList>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="����execl" />
                <asp:Button ID="btEcexl" runat="server" OnClick="btEcexl_Click" Text="��������" />
            </td>
		</tr>
	</table>
            </div>
            <div class="auditclub">
                <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <td>���</td>
                            <td>״̬</td>
                            <%--<td>����</td>--%>
                            <td>�ǳ�</td>
                            <td>����</td>
                            <%--<td>�Ա�</td>--%>
                            <td>֤������</td>
                            <td>��ϵ��ʽ</td>
                            <td>����</td>
                            <td>����</td>
                            <td>�����ע</td>
                            <td>����</td>
                            <td>����</td>
                            <td>����</td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <a name='a<%# Eval("id")%>'></a>
                            <%# Container.ItemIndex + 1%>
                           <%-- <%# DataBinder.Eval(Container.DataItem, "id")%>--%>
                        </td>
                        <td><%# Eval("iStatus").ToString() == "0" ? "�����" : Eval("iStatus").ToString() == "1"?"δ����":Eval("iStatus").ToString() == "2" ? "�Ѹ���":Eval("iStatus").ToString() == "3" ? "�����":"�ѹ���"%></td>
                        <%--<td><%# DataBinder.Eval(Container.DataItem, "cCloth")%></td>--%>
                        <td> <%# GetNick(Eval("idUser").ToString())%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>
                        <%--<td><%# Eval("idGender").ToString() == "0" ? "��" :"Ů"%></td>--%>
                        <td><%# DataBinder.Eval(Container.DataItem, "IdNo")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMobile")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMail")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cCityname")%></td>
                        <%--<td><%# Eval("cMake3").ToString() == "1" ? "ͨ��":"δͨ��"%></td>--%>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMake3")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "fj")%></td>
                         <td><%# DataBinder.Eval(Container.DataItem, "bj")%></td>
                        <td><%# Eval("iScore").ToString() == "0" ? "��" :"��"%></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr bgcolor="#e8e8e8">
                        <td>
                            <a name='a<%# Eval("id")%>'></a>
                            <%# Container.ItemIndex + 1%>
                           <%-- <%# DataBinder.Eval(Container.DataItem, "id")%>--%>
                        </td>
                        <td><%# Eval("iStatus").ToString() == "0" ? "�����" : Eval("iStatus").ToString() == "1"?"δ����":Eval("iStatus").ToString() == "2" ? "�Ѹ���":Eval("iStatus").ToString() == "3" ? "�����":"�ѹ���"%></td>
                        <%--<td><%# DataBinder.Eval(Container.DataItem, "cCloth")%></td>--%>
                        <td> <%# GetNick(Eval("idUser").ToString())%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>
                        <%--<td><%# Eval("idGender").ToString() == "0" ? "��" :"Ů"%></td>--%>
                        <td><%# DataBinder.Eval(Container.DataItem, "IdNo")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMobile")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMail")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cCityname")%></td>
                         <%--<td><%# Eval("cMake3").ToString() == "1" ? "ͨ��":"δͨ��"%></td>--%>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMake3")%></td>
                        
                        <td><%# DataBinder.Eval(Container.DataItem, "fj")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "bj")%></td>
                        <td><%# Eval("iScore").ToString() == "0" ? "��" :"��"%></td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater> 
            </div>
            <asp:GridView ID="gvAll" runat="server" AutoGenerateColumns="False" GridLines="None">
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <Columns>
                  <%--<asp:TemplateField HeaderText="֧��״̬">                        
                        <ItemTemplate>
                            <%# Eval("iStatus").ToString() == "0" ? "�����" : Eval("iStatus").ToString() == "1"?"δ����":Eval("iStatus").ToString() == "2" ? "�Ѹ���":Eval("iStatus").ToString() == "3" ? "�����":"�ѹ���"%>
                        </ItemTemplate>
                        <HeaderStyle Width="82px" />
                    </asp:TemplateField>--%>
                <asp:BoundField DataField="cCompetitionName" HeaderText="��������">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cType" HeaderText="����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cFullname" HeaderText="����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                 <asp:BoundField DataField="iSNo" HeaderText="��ӱ��">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <%--<asp:TemplateField HeaderText="��ӱ��">
                    <ItemTemplate>
                        <%#GetTeamID(Eval("idSignUp").ToString(),Eval("idUser").ToString()) %>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>      --%>
                <asp:BoundField DataField="cCloth" HeaderText="��װ����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="�Ա�">                   
                    <ItemTemplate>
                        <%# Eval("cGender").ToString() == "0" ? "��" :"Ů"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ѫ��">                   
                    <ItemTemplate>
                        <%# Eval("idBlood").ToString() == "0" ? "A" : Eval("idBlood").ToString() == "1"?"B":Eval("idBlood").ToString() == "2" ? "O":Eval("idBlood").ToString() == "3" ? "AB":"����"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="��������">                   
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("dBirthday", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="֤������">                    
                    <ItemTemplate>
                        <%# Eval("IdType").ToString() == "1" ? "���֤" : Eval("IdType").ToString() == "2"?"����֤":Eval("IdType").ToString() == "3" ? "���ڱ�":Eval("IdType").ToString() == "4" ? "����":"δѡ��"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="IdNo" HeaderText="֤������">
                    <ItemStyle Width="170px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cMobile" HeaderText="��ϵ��ʽ">
                    <ItemStyle Width="100px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cMail" HeaderText="����">
                    <ItemStyle Width="190px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cCityname" HeaderText="����" ReadOnly="True">
                    <ItemStyle Width="100px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cAddress" HeaderText="��ַ">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cZipcode" HeaderText="�ʱ�">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                 <asp:TemplateField HeaderText="ְҵ">
                        <ItemTemplate>                          
                              <%#GetidOccupation(Eval("idOccupation").ToString()) %>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>
                <asp:TemplateField HeaderText="ѧ��">                    
                    <ItemTemplate>
                        <%# Eval("idEducation").ToString() == "1" ? "��ר" : Eval("idEducation").ToString() == "2"?"����":Eval("idEducation").ToString() == "3" ? "�о���":Eval("idEducation").ToString() == "4" ? "��ʿ":Eval("idEducation").ToString() == "5" ? "˶ʿ":"����"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="cEmergerContact" HeaderText="������ϵ��">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField>   
                 <asp:BoundField DataField="cNational" HeaderText="����">                  
                </asp:BoundField>  
                <%--<asp:BoundField DataField="iCost" HeaderText="�۸�">
                </asp:BoundField>        --%>            
                <asp:BoundField DataField="cECG" HeaderText="λ��1">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="cFinished" HeaderText="λ��2">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake" HeaderText="λ��3">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake1" HeaderText="λ��4">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake2" HeaderText="λ��5">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="cShoe" HeaderText="Ь��/����ǩ���ص�">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="dCreate" HeaderText="����ʱ��">
                         </asp:BoundField>
                 <asp:BoundField DataField="iCost" HeaderText="�۸�">
                         </asp:BoundField>
                <asp:BoundField DataField="idUser" HeaderText="�û�ID">
                         </asp:BoundField>
                 <%--<asp:TemplateField HeaderText="������Ʒ">
                        <ItemTemplate>                          
                              <%#GetAnnexLog(Eval("9").ToString(),Eval("idUser").ToString()) %>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>--%>
                <asp:BoundField DataField="cMake3" HeaderText="�����ע">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="iScore" HeaderText="ʹ�û���">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField> 
                <%-- <asp:TemplateField HeaderText="ʹ�û���">
                        <ItemTemplate>                          
                             <%# Eval("iScore").ToString() == "0" ? "��" :"��"%>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>--%>
                 <asp:BoundField DataField="cOrder_no" HeaderText="������">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="cParentOrder" HeaderText="���׺�">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:TemplateField HeaderText="�Ƿ�ͬ�ⱨ����֪">
                        <ItemTemplate>                          
                           ��
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
            </Columns>
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
            <asp:GridView ID="gvZbJd" runat="server" AutoGenerateColumns="false" GridLines="None">
                <FooterStyle BackColor="#990000" Font-Bold="true" ForeColor="White" />

                <Columns>
                <asp:BoundField DataField="cCompetitionName" HeaderText="��������">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                    <asp:BoundField DataField="cItemName" HeaderText="��Ŀ����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cFullname" HeaderText="����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>

                <asp:BoundField DataField="cFullname" HeaderText="����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                
                <asp:TemplateField HeaderText="�Ա�">                   
                    <ItemTemplate>
                        <%# Eval("cGender").ToString() == "0" ? "��" :"Ů"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ѫ��">                   
                    <ItemTemplate>
                        <%# Eval("idBlood").ToString() == "0" ? "A" : Eval("idBlood").ToString() == "1"?"B":Eval("idBlood").ToString() == "2" ? "O":Eval("idBlood").ToString() == "3" ? "AB":"����"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="��������">                   
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("dBirthday", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="֤������">                    
                    <ItemTemplate>
                        <%# Eval("IdType").ToString() == "1" ? "���֤" : Eval("IdType").ToString() == "2"?"����֤":Eval("IdType").ToString() == "3" ? "���ڱ�":Eval("IdType").ToString() == "4" ? "����":"δѡ��"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="IdNo" HeaderText="֤������">
                    <ItemStyle Width="170px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cMobile" HeaderText="��ϵ��ʽ">
                    <ItemStyle Width="100px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cMail" HeaderText="����">
                    <ItemStyle Width="190px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cCityname" HeaderText="����" ReadOnly="True">
                    <ItemStyle Width="100px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cAddress" HeaderText="��ַ">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cZipcode" HeaderText="�ʱ�">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                    <asp:BoundField DataField="idUser" HeaderText="�û�ID" />
                    <asp:BoundField DataField="cMake3" HeaderText="�����ע">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                    <asp:BoundField DataField="dCreate" HeaderText="����ʱ��">
                         </asp:BoundField>
                    <asp:BoundField DataField="cOrder_no" HeaderText="������">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <%--<asp:BoundField DataField="cParentOrder" HeaderText="���׺�">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> --%>
                <asp:TemplateField HeaderText="�Ƿ�ͬ�ⱨ����֪">
                        <ItemTemplate>                          
                           ��
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
            
             </center>
    </form>
    <script>
        function ForOnChange() {
            var saishi = $("#DDLRace").val();
            window.location.href = "/Admin/Backstage/ExportOrders.aspx?Race=" + saishi
            
        }
        </script>
</body>
</html>
