<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="RaceListRecord.aspx.cs" Inherits="Admin_RaceListRecord" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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

    table {
        color: #666;
       
    }

        table tr td:first-child {
            width: 120px;
            text-align: right;
        }

        table tr td:last-child {
            width: 410px;
        }

        table tr {
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
        width: 80px;
    }

    table tr td:last-child input {
        float: left;
        margin-left: 4px;
    }

    table tr td:last-child label {
        float: left;
        margin-left: 3px;
        margin-right: 4px;
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

    table tr .project label {
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

    .gtable {
        width: 100%;
        overflow: auto;
    }

    #GVmain th {
        height: 20px;
        line-height: 20px;
        text-align: center;
    }

    #GVmain td {
        height: 20px;
        line-height: 20px;
        text-align: center;
    }

    #GVmain input {
        width: 80px;margin-bottom: 0px;
    }

    #GVmain tr {
        border-bottom: 1px dotted #ccc;
    }

        #GVmain tr:first-child {
            border: 0;
        }
</style>
<div class="cont">
	<div class="conttop">
		<a href="/" >��ҳ</a>  >
<a href="/Admin/RaceList.aspx">������ҳ</a>>
		������Ϣ�鿴
	</div>
	<table style="width:100%">
		<tr>
			<td><label for="ssname">ѡ�����£�</label></td>
			<td>
                <asp:DropDownList ID="DDLRace" runat="server" OnSelectedIndexChanged="DDLRace_SelectedIndexChanged"  AutoPostBack="true">
                </asp:DropDownList><asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" ></asp:RadioButtonList>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="����execl" />
                <asp:Button ID="btEcexl" runat="server" OnClick="btEcexl_Click" Text="��������" />
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="�����" />
                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="���б���" />
            </td>
		</tr>
	</table>
<div style="display:none">
    <div id="tips" >
    </div>  
</div>
</div>
</center>
        <div class="gtable">
            <asp:GridView ID="GVmain" runat="server" AutoGenerateColumns="False" GridLines="None" OnRowDeleting="GVmain_RowDeleting" OnRowEditing="GVmain_RowEditing"
                OnRowUpdating="GVmain_RowUpdating" OnRowCancelingEdit="GVmain_RowCancelingEdit" Width="100%">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="#">
                     <ItemTemplate>
                         <%#GVmain.PageIndex * GVmain.PageSize + GVmain.Rows.Count + 1%>
                     </ItemTemplate>
                           <ItemStyle Width="30px" />
                        </asp:TemplateField>
                    <asp:TemplateField HeaderText="״̬">
                        <EditItemTemplate>
                            <asp:TextBox ID="iState" runat="server" Text='<%# Bind("iState") %>' ToolTip="0�����,1δ����,2�Ѹ���,3�����,����ֵΪ�ѹ���"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("iState").ToString() == "0" ? "�����" : Eval("iState").ToString() == "1"?"δ����":Eval("iState").ToString() == "2" ? "�Ѹ���":Eval("iState").ToString() == "3" ? "�����":"�ѹ���"%>
                        </ItemTemplate>
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="cCloth" HeaderText="��װ����">                       
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="�ǳ�">
                        <ItemTemplate>                          
                              <%# GetNick(Eval("idUser").ToString())%>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>
                    <asp:BoundField DataField="cName" HeaderText="����">                       
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="�Ա�">
                        <EditItemTemplate>
                            <asp:TextBox ID="idGender" runat="server" Text='<%# Bind("idGender") %>' ToolTip="0��,1Ů"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("idGender").ToString() == "0" ? "��" :"Ů"%>
                        </ItemTemplate>
                        <ItemStyle/>
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="cNationID" HeaderText="֤������">
                    </asp:BoundField>
                    <asp:BoundField DataField="cMobile" HeaderText="��ϵ��ʽ">
                        <ItemStyle Width="80px"></ItemStyle>                
                    </asp:BoundField>
                    <asp:BoundField DataField="cMail" HeaderText="����">
                    </asp:BoundField>
                    <asp:BoundField DataField="cRemark1" HeaderText="�����ע">
                    </asp:BoundField>
                    <asp:BoundField DataField="cCityname" HeaderText="����" ReadOnly="True">  
                        <ItemStyle Width="80px"></ItemStyle>                     
                    </asp:BoundField>                
                    <asp:TemplateField HeaderText="id" Visible="false">
                        <ItemTemplate>                       
                            <asp:Label ID="sid" runat="server" Text='<%# Eval("id") %>' />
                        </ItemTemplate>
                        <ItemStyle />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="֤��">                   
                        <ItemTemplate> 
                            <%# Eval("cHealthUrl").ToString().Trim()==""?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cHealthUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%# Eval("cOrigin").ToString().Trim()==""?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cOrigin").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%# Eval("cMake").ToString().Trim()==""?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cMake").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%# Eval("cRemark2").ToString().Trim()==""?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cRemark2").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                        </ItemTemplate>
                        <ItemStyle Width="60px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="dPay" HeaderText="ʱ��">
                    </asp:BoundField>
                    <asp:BoundField DataField="idUser" HeaderText="ID">
                    </asp:BoundField>
                    <asp:CommandField HeaderText="�༭" ShowEditButton="True">
                        <ItemStyle Width="60px"></ItemStyle>
                    </asp:CommandField>
                </Columns>
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </div>
        <asp:GridView ID="GVmain0" runat="server" AutoGenerateColumns="False" GridLines="None">
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <Columns>
                  <asp:TemplateField HeaderText="֧��״̬">
                        <EditItemTemplate>
                            <asp:TextBox ID="iState" runat="server" Text='<%# Bind("iState") %>' ToolTip="0�����,1δ����,2�Ѹ���,����ֵΪ�ѹ���"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("iState").ToString() == "0" ? "�����" : Eval("iState").ToString() == "1"?"δ����":Eval("iState").ToString() == "2" ? "�Ѹ���":Eval("iState").ToString() == "3" ? "�����":"�ѹ���"%>
                        </ItemTemplate>
                        <HeaderStyle Width="82px" />
                    </asp:TemplateField>
                <asp:BoundField DataField="cName" HeaderText="����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="��ӱ��">                   
                    <ItemTemplate>
                        <%#GetTeamID(Eval("idSignUp").ToString(),Eval("idUser").ToString()) %>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>      
                <asp:BoundField DataField="cCloth" HeaderText="��װ����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="�Ա�">
                    <EditItemTemplate>
                        <asp:TextBox ID="idGender" runat="server" Text='<%# Bind("idGender") %>' ToolTip="0��,1Ů"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# Eval("idGender").ToString() == "0" ? "��" :"Ů"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ѫ��">
                    <EditItemTemplate>
                        <asp:TextBox ID="idBlood" runat="server" Text='<%# Bind("idBlood") %>' ToolTip="0A,1B,2O,3AB,4����"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# Eval("idBlood").ToString() == "0" ? "A" : Eval("idBlood").ToString() == "1"?"B":Eval("idBlood").ToString() == "2" ? "O":Eval("idBlood").ToString() == "3" ? "AB":"����"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="��������">
                    <EditItemTemplate>
                        <asp:TextBox ID="dBirthday" runat="server" Text='<%# Bind("dBirthday", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("dBirthday", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="֤������">
                    <EditItemTemplate>
                        <asp:TextBox ID="idNationIDType" runat="server" Text='<%# Bind("idNationIDType") %>' ToolTip="1���֤,2����֤,3���ڱ�,4����"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# Eval("idNationIDType").ToString() == "1" ? "���֤" : Eval("idNationIDType").ToString() == "2"?"����֤":Eval("idNationIDType").ToString() == "3" ? "���ڱ�":Eval("idNationIDType").ToString() == "4" ? "����":"δѡ��"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="cNationID" HeaderText="֤������">
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
                <asp:BoundField DataField="cEmergerContact" HeaderText="������ϵ��">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField>   
                 <asp:BoundField DataField="cGJ" HeaderText="����">                  
                </asp:BoundField>  
                <asp:BoundField DataField="iCost" HeaderText="�۸�">                  
                </asp:BoundField>                    
                 <asp:BoundField DataField="cOrigin" HeaderText="��ע1">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake" HeaderText="��ע2">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cRemark1" HeaderText="��ע3">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="dPay" HeaderText="ʱ��">
                    </asp:BoundField>
                    <asp:BoundField DataField="idUser" HeaderText="ID">
                         </asp:BoundField>
                 <asp:TemplateField HeaderText="�ǳ�">
                        <ItemTemplate>                          
                              <%# GetNick(Eval("idUser").ToString())%>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>
            </Columns>
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
        <asp:GridView ID="gvAll" runat="server" AutoGenerateColumns="False" GridLines="None">
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <Columns>
                  <asp:TemplateField HeaderText="֧��״̬">                        
                        <ItemTemplate>
                            <%# Eval("iState").ToString() == "0" ? "�����" : Eval("iState").ToString() == "1"?"δ����":Eval("iState").ToString() == "2" ? "�Ѹ���":Eval("iState").ToString() == "3" ? "�����":"�ѹ���"%>
                        </ItemTemplate>
                        <HeaderStyle Width="82px" />
                    </asp:TemplateField>
                <asp:BoundField DataField="cTitle" HeaderText="��������">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cType" HeaderText="����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cName" HeaderText="����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="��ӱ��">                   
                    <ItemTemplate>
                        <%#GetTeamID(Eval("idSignUp").ToString(),Eval("idUser").ToString()) %>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>      
                <asp:BoundField DataField="cCloth" HeaderText="��װ����">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="�Ա�">                   
                    <ItemTemplate>
                        <%# Eval("idGender").ToString() == "0" ? "��" :"Ů"%>
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
                        <%# Eval("idNationIDType").ToString() == "1" ? "���֤" : Eval("idNationIDType").ToString() == "2"?"����֤":Eval("idNationIDType").ToString() == "3" ? "���ڱ�":Eval("idNationIDType").ToString() == "4" ? "����":"δѡ��"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="cNationID" HeaderText="֤������">
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
                <asp:BoundField DataField="cEmergerContact" HeaderText="������ϵ��">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField>   
                 <asp:BoundField DataField="cGJ" HeaderText="����">                  
                </asp:BoundField>  
                <asp:BoundField DataField="iCost" HeaderText="�۸�">                  
                </asp:BoundField>                    
                 <asp:BoundField DataField="cOrigin" HeaderText="��ע1">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake" HeaderText="��ע2">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cRemark1" HeaderText="��ע3">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="dPay" HeaderText="ʱ��">
                    </asp:BoundField>
                    <asp:BoundField DataField="idUser" HeaderText="ID">
                         </asp:BoundField>
                 <asp:TemplateField HeaderText="�ǳ�">
                        <ItemTemplate>                          
                              <%# GetNick(Eval("idUser").ToString())%>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>
            </Columns>
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
    </form>
</body>
</html>
