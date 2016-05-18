<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="RaceListRecord.aspx.cs" Inherits="Admin_RaceListRecord" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
        font-family: 微软雅黑;
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
		<a href="/" >首页</a>  >
<a href="/Admin/RaceList.aspx">赛事首页</a>>
		报名信息查看
	</div>
	<table style="width:100%">
		<tr>
			<td><label for="ssname">选择赛事：</label></td>
			<td>
                <asp:DropDownList ID="DDLRace" runat="server" OnSelectedIndexChanged="DDLRace_SelectedIndexChanged"  AutoPostBack="true">
                </asp:DropDownList><asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" ></asp:RadioButtonList>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="导出execl" />
                <asp:Button ID="btEcexl" runat="server" OnClick="btEcexl_Click" Text="导出所有" />
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="待审核" />
                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="所有报名" />
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
                    <asp:TemplateField HeaderText="状态">
                        <EditItemTemplate>
                            <asp:TextBox ID="iState" runat="server" Text='<%# Bind("iState") %>' ToolTip="0待审核,1未付款,2已付款,3已组队,其他值为已过期"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("iState").ToString() == "0" ? "待审核" : Eval("iState").ToString() == "1"?"未付款":Eval("iState").ToString() == "2" ? "已付款":Eval("iState").ToString() == "3" ? "已组队":"已过期"%>
                        </ItemTemplate>
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="cCloth" HeaderText="服装尺码">                       
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="昵称">
                        <ItemTemplate>                          
                              <%# GetNick(Eval("idUser").ToString())%>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>
                    <asp:BoundField DataField="cName" HeaderText="姓名">                       
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="性别">
                        <EditItemTemplate>
                            <asp:TextBox ID="idGender" runat="server" Text='<%# Bind("idGender") %>' ToolTip="0男,1女"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("idGender").ToString() == "0" ? "男" :"女"%>
                        </ItemTemplate>
                        <ItemStyle/>
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="cNationID" HeaderText="证件号码">
                    </asp:BoundField>
                    <asp:BoundField DataField="cMobile" HeaderText="联系方式">
                        <ItemStyle Width="80px"></ItemStyle>                
                    </asp:BoundField>
                    <asp:BoundField DataField="cMail" HeaderText="邮箱">
                    </asp:BoundField>
                    <asp:BoundField DataField="cRemark1" HeaderText="审核批注">
                    </asp:BoundField>
                    <asp:BoundField DataField="cCityname" HeaderText="城市" ReadOnly="True">  
                        <ItemStyle Width="80px"></ItemStyle>                     
                    </asp:BoundField>                
                    <asp:TemplateField HeaderText="id" Visible="false">
                        <ItemTemplate>                       
                            <asp:Label ID="sid" runat="server" Text='<%# Eval("id") %>' />
                        </ItemTemplate>
                        <ItemStyle />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="证件">                   
                        <ItemTemplate> 
                            <%# Eval("cHealthUrl").ToString().Trim()==""?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cHealthUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%# Eval("cOrigin").ToString().Trim()==""?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cOrigin").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%# Eval("cMake").ToString().Trim()==""?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cMake").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%# Eval("cRemark2").ToString().Trim()==""?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cRemark2").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                        </ItemTemplate>
                        <ItemStyle Width="60px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="dPay" HeaderText="时间">
                    </asp:BoundField>
                    <asp:BoundField DataField="idUser" HeaderText="ID">
                    </asp:BoundField>
                    <asp:CommandField HeaderText="编辑" ShowEditButton="True">
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
                  <asp:TemplateField HeaderText="支付状态">
                        <EditItemTemplate>
                            <asp:TextBox ID="iState" runat="server" Text='<%# Bind("iState") %>' ToolTip="0待审核,1未付款,2已付款,其他值为已过期"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("iState").ToString() == "0" ? "待审核" : Eval("iState").ToString() == "1"?"未付款":Eval("iState").ToString() == "2" ? "已付款":Eval("iState").ToString() == "3" ? "已组队":"已过期"%>
                        </ItemTemplate>
                        <HeaderStyle Width="82px" />
                    </asp:TemplateField>
                <asp:BoundField DataField="cName" HeaderText="姓名">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="组队编号">                   
                    <ItemTemplate>
                        <%#GetTeamID(Eval("idSignUp").ToString(),Eval("idUser").ToString()) %>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>      
                <asp:BoundField DataField="cCloth" HeaderText="服装尺码">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="性别">
                    <EditItemTemplate>
                        <asp:TextBox ID="idGender" runat="server" Text='<%# Bind("idGender") %>' ToolTip="0男,1女"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# Eval("idGender").ToString() == "0" ? "男" :"女"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="血型">
                    <EditItemTemplate>
                        <asp:TextBox ID="idBlood" runat="server" Text='<%# Bind("idBlood") %>' ToolTip="0A,1B,2O,3AB,4其他"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# Eval("idBlood").ToString() == "0" ? "A" : Eval("idBlood").ToString() == "1"?"B":Eval("idBlood").ToString() == "2" ? "O":Eval("idBlood").ToString() == "3" ? "AB":"其他"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="出生日期">
                    <EditItemTemplate>
                        <asp:TextBox ID="dBirthday" runat="server" Text='<%# Bind("dBirthday", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("dBirthday", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="证件类型">
                    <EditItemTemplate>
                        <asp:TextBox ID="idNationIDType" runat="server" Text='<%# Bind("idNationIDType") %>' ToolTip="1身份证,2军官证,3户口本,4其他"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# Eval("idNationIDType").ToString() == "1" ? "身份证" : Eval("idNationIDType").ToString() == "2"?"军官证":Eval("idNationIDType").ToString() == "3" ? "户口本":Eval("idNationIDType").ToString() == "4" ? "其他":"未选择"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="cNationID" HeaderText="证件号码">
                    <ItemStyle Width="170px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cMobile" HeaderText="联系方式">
                    <ItemStyle Width="100px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cMail" HeaderText="邮箱">
                    <ItemStyle Width="190px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cCityname" HeaderText="城市" ReadOnly="True">
                    <ItemStyle Width="100px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cAddress" HeaderText="地址">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cZipcode" HeaderText="邮编">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cEmergerContact" HeaderText="紧急联系人">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField>   
                 <asp:BoundField DataField="cGJ" HeaderText="国籍">                  
                </asp:BoundField>  
                <asp:BoundField DataField="iCost" HeaderText="价格">                  
                </asp:BoundField>                    
                 <asp:BoundField DataField="cOrigin" HeaderText="备注1">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake" HeaderText="备注2">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cRemark1" HeaderText="备注3">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="dPay" HeaderText="时间">
                    </asp:BoundField>
                    <asp:BoundField DataField="idUser" HeaderText="ID">
                         </asp:BoundField>
                 <asp:TemplateField HeaderText="昵称">
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
                  <asp:TemplateField HeaderText="支付状态">                        
                        <ItemTemplate>
                            <%# Eval("iState").ToString() == "0" ? "待审核" : Eval("iState").ToString() == "1"?"未付款":Eval("iState").ToString() == "2" ? "已付款":Eval("iState").ToString() == "3" ? "已组队":"已过期"%>
                        </ItemTemplate>
                        <HeaderStyle Width="82px" />
                    </asp:TemplateField>
                <asp:BoundField DataField="cTitle" HeaderText="赛事名称">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cType" HeaderText="类型">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cName" HeaderText="姓名">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="组队编号">                   
                    <ItemTemplate>
                        <%#GetTeamID(Eval("idSignUp").ToString(),Eval("idUser").ToString()) %>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>      
                <asp:BoundField DataField="cCloth" HeaderText="服装尺码">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="性别">                   
                    <ItemTemplate>
                        <%# Eval("idGender").ToString() == "0" ? "男" :"女"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="血型">                   
                    <ItemTemplate>
                        <%# Eval("idBlood").ToString() == "0" ? "A" : Eval("idBlood").ToString() == "1"?"B":Eval("idBlood").ToString() == "2" ? "O":Eval("idBlood").ToString() == "3" ? "AB":"其他"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="出生日期">                   
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("dBirthday", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="证件类型">                    
                    <ItemTemplate>
                        <%# Eval("idNationIDType").ToString() == "1" ? "身份证" : Eval("idNationIDType").ToString() == "2"?"军官证":Eval("idNationIDType").ToString() == "3" ? "户口本":Eval("idNationIDType").ToString() == "4" ? "其他":"未选择"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="cNationID" HeaderText="证件号码">
                    <ItemStyle Width="170px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cMobile" HeaderText="联系方式">
                    <ItemStyle Width="100px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cMail" HeaderText="邮箱">
                    <ItemStyle Width="190px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cCityname" HeaderText="城市" ReadOnly="True">
                    <ItemStyle Width="100px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cAddress" HeaderText="地址">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cZipcode" HeaderText="邮编">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cEmergerContact" HeaderText="紧急联系人">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField>   
                 <asp:BoundField DataField="cGJ" HeaderText="国籍">                  
                </asp:BoundField>  
                <asp:BoundField DataField="iCost" HeaderText="价格">                  
                </asp:BoundField>                    
                 <asp:BoundField DataField="cOrigin" HeaderText="备注1">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake" HeaderText="备注2">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cRemark1" HeaderText="备注3">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="dPay" HeaderText="时间">
                    </asp:BoundField>
                    <asp:BoundField DataField="idUser" HeaderText="ID">
                         </asp:BoundField>
                 <asp:TemplateField HeaderText="昵称">
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
