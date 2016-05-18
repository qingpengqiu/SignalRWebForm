<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExportOrders.aspx.cs" Inherits="Admin_Backstage_ExportOrders" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理入口-益跑网</title>
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
                font-family: 微软雅黑;
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
		<a href="/" >首页</a>  >
<a href="/Admin/RaceList.aspx">赛事首页</a>>
		报名信息查看
	</div>
            <table style="width:100%">
		<tr>
			<td>选择赛事：<%--<asp:DropDownList ID="DDLRace" runat="server" OnSelectedIndexChanged="DDLRace_SelectedIndexChanged"  AutoPostBack="true">
                </asp:DropDownList>--%><select id="DDLRace" runat="server" style="width: 200px;" onchange="ForOnChange()"></select>
            </td>
		</tr>
                <tr>
                    <td>
                        
                    <asp:RadioButtonList ID="rdbid" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbid_Selected">
                        <asp:ListItem Value="2" >赛事</asp:ListItem>
                        <asp:ListItem Value="4">酒店</asp:ListItem>
                        <asp:ListItem Value="5" >旅游</asp:ListItem>
                        <asp:ListItem Value="8">装备</asp:ListItem>
                        <asp:ListItem Value="9" >附加项</asp:ListItem>
                        </asp:RadioButtonList>
                        <%--<select id="iType" name="iType" runat="server" style="width: 200px;">
                                                <option value="3" >附加项</option>
                                                <option value="1" selected>赛事</option>
                                                <option value="2">酒店</option>
                                            </select>
<asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>--%>
                        <%--<asp:Button ID="Button2" runat="server" Text="赛事"  OnClick="Button2_Click"></asp:Button>
                        <asp:Button ID="Button3" runat="server" Text="酒店"  OnClick="Button3_Click"></asp:Button>
                        <asp:Button ID="Button4" runat="server" Text="附加项" OnClick="Button4_Click"></asp:Button>--%>
                        </td>
                </tr>
		<tr>
			<td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" Visible="False" ></asp:RadioButtonList>
                <asp:RadioButtonList ID="jdradio" runat="server" OnSelectedIndexChanged="jdradio_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" ></asp:RadioButtonList>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="导出execl" />
                <asp:Button ID="btEcexl" runat="server" OnClick="btEcexl_Click" Text="导出所有" />
            </td>
		</tr>
	</table>
            </div>
            <div class="auditclub">
                <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <td>编号</td>
                            <td>状态</td>
                            <%--<td>尺码</td>--%>
                            <td>昵称</td>
                            <td>姓名</td>
                            <%--<td>性别</td>--%>
                            <td>证件号码</td>
                            <td>联系方式</td>
                            <td>邮箱</td>
                            <td>城市</td>
                            <td>审核批注</td>
                            <td>附件</td>
                            <td>操作</td>
                            <td>积分</td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <a name='a<%# Eval("id")%>'></a>
                            <%# Container.ItemIndex + 1%>
                           <%-- <%# DataBinder.Eval(Container.DataItem, "id")%>--%>
                        </td>
                        <td><%# Eval("iStatus").ToString() == "0" ? "待审核" : Eval("iStatus").ToString() == "1"?"未付款":Eval("iStatus").ToString() == "2" ? "已付款":Eval("iStatus").ToString() == "3" ? "已组队":"已过期"%></td>
                        <%--<td><%# DataBinder.Eval(Container.DataItem, "cCloth")%></td>--%>
                        <td> <%# GetNick(Eval("idUser").ToString())%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>
                        <%--<td><%# Eval("idGender").ToString() == "0" ? "男" :"女"%></td>--%>
                        <td><%# DataBinder.Eval(Container.DataItem, "IdNo")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMobile")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMail")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cCityname")%></td>
                        <%--<td><%# Eval("cMake3").ToString() == "1" ? "通过":"未通过"%></td>--%>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMake3")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "fj")%></td>
                         <td><%# DataBinder.Eval(Container.DataItem, "bj")%></td>
                        <td><%# Eval("iScore").ToString() == "0" ? "否" :"是"%></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr bgcolor="#e8e8e8">
                        <td>
                            <a name='a<%# Eval("id")%>'></a>
                            <%# Container.ItemIndex + 1%>
                           <%-- <%# DataBinder.Eval(Container.DataItem, "id")%>--%>
                        </td>
                        <td><%# Eval("iStatus").ToString() == "0" ? "待审核" : Eval("iStatus").ToString() == "1"?"未付款":Eval("iStatus").ToString() == "2" ? "已付款":Eval("iStatus").ToString() == "3" ? "已组队":"已过期"%></td>
                        <%--<td><%# DataBinder.Eval(Container.DataItem, "cCloth")%></td>--%>
                        <td> <%# GetNick(Eval("idUser").ToString())%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>
                        <%--<td><%# Eval("idGender").ToString() == "0" ? "男" :"女"%></td>--%>
                        <td><%# DataBinder.Eval(Container.DataItem, "IdNo")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMobile")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMail")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cCityname")%></td>
                         <%--<td><%# Eval("cMake3").ToString() == "1" ? "通过":"未通过"%></td>--%>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMake3")%></td>
                        
                        <td><%# DataBinder.Eval(Container.DataItem, "fj")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "bj")%></td>
                        <td><%# Eval("iScore").ToString() == "0" ? "否" :"是"%></td>
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
                  <%--<asp:TemplateField HeaderText="支付状态">                        
                        <ItemTemplate>
                            <%# Eval("iStatus").ToString() == "0" ? "待审核" : Eval("iStatus").ToString() == "1"?"未付款":Eval("iStatus").ToString() == "2" ? "已付款":Eval("iStatus").ToString() == "3" ? "已组队":"已过期"%>
                        </ItemTemplate>
                        <HeaderStyle Width="82px" />
                    </asp:TemplateField>--%>
                <asp:BoundField DataField="cCompetitionName" HeaderText="赛事名称">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cType" HeaderText="类型">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cFullname" HeaderText="姓名">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                 <asp:BoundField DataField="iSNo" HeaderText="组队编号">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <%--<asp:TemplateField HeaderText="组队编号">
                    <ItemTemplate>
                        <%#GetTeamID(Eval("idSignUp").ToString(),Eval("idUser").ToString()) %>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>      --%>
                <asp:BoundField DataField="cCloth" HeaderText="服装尺码">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="性别">                   
                    <ItemTemplate>
                        <%# Eval("cGender").ToString() == "0" ? "男" :"女"%>
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
                        <%# Eval("IdType").ToString() == "1" ? "身份证" : Eval("IdType").ToString() == "2"?"军官证":Eval("IdType").ToString() == "3" ? "户口本":Eval("IdType").ToString() == "4" ? "其他":"未选择"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="IdNo" HeaderText="证件号码">
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
                 <asp:TemplateField HeaderText="职业">
                        <ItemTemplate>                          
                              <%#GetidOccupation(Eval("idOccupation").ToString()) %>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>
                <asp:TemplateField HeaderText="学历">                    
                    <ItemTemplate>
                        <%# Eval("idEducation").ToString() == "1" ? "大专" : Eval("idEducation").ToString() == "2"?"本科":Eval("idEducation").ToString() == "3" ? "研究生":Eval("idEducation").ToString() == "4" ? "博士":Eval("idEducation").ToString() == "5" ? "硕士":"其他"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="cEmergerContact" HeaderText="紧急联系人">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField>   
                 <asp:BoundField DataField="cNational" HeaderText="国籍">                  
                </asp:BoundField>  
                <%--<asp:BoundField DataField="iCost" HeaderText="价格">
                </asp:BoundField>        --%>            
                <asp:BoundField DataField="cECG" HeaderText="位置1">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="cFinished" HeaderText="位置2">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake" HeaderText="位置3">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake1" HeaderText="位置4">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cMake2" HeaderText="位置5">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="cShoe" HeaderText="鞋号/护照签发地点">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="dCreate" HeaderText="付款时间">
                         </asp:BoundField>
                 <asp:BoundField DataField="iCost" HeaderText="价格">
                         </asp:BoundField>
                <asp:BoundField DataField="idUser" HeaderText="用户ID">
                         </asp:BoundField>
                 <%--<asp:TemplateField HeaderText="附属产品">
                        <ItemTemplate>                          
                              <%#GetAnnexLog(Eval("9").ToString(),Eval("idUser").ToString()) %>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>--%>
                <asp:BoundField DataField="cMake3" HeaderText="审核批注">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="iScore" HeaderText="使用积分">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField> 
                <%-- <asp:TemplateField HeaderText="使用积分">
                        <ItemTemplate>                          
                             <%# Eval("iScore").ToString() == "0" ? "否" :"是"%>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>--%>
                 <asp:BoundField DataField="cOrder_no" HeaderText="订单号">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="cParentOrder" HeaderText="交易号">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:TemplateField HeaderText="是否同意报名须知">
                        <ItemTemplate>                          
                           是
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
                <asp:BoundField DataField="cCompetitionName" HeaderText="赛事名称">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                    <asp:BoundField DataField="cItemName" HeaderText="项目名称">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="cFullname" HeaderText="姓名">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>

                <asp:BoundField DataField="cFullname" HeaderText="姓名">
                    <ItemStyle Width="80px"></ItemStyle>
                </asp:BoundField>
                
                <asp:TemplateField HeaderText="性别">                   
                    <ItemTemplate>
                        <%# Eval("cGender").ToString() == "0" ? "男" :"女"%>
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
                        <%# Eval("IdType").ToString() == "1" ? "身份证" : Eval("IdType").ToString() == "2"?"军官证":Eval("IdType").ToString() == "3" ? "户口本":Eval("IdType").ToString() == "4" ? "其他":"未选择"%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:BoundField DataField="IdNo" HeaderText="证件号码">
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
                    <asp:BoundField DataField="idUser" HeaderText="用户ID" />
                    <asp:BoundField DataField="cMake3" HeaderText="审核批注">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                    <asp:BoundField DataField="dCreate" HeaderText="付款时间">
                         </asp:BoundField>
                    <asp:BoundField DataField="cOrder_no" HeaderText="订单号">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <%--<asp:BoundField DataField="cParentOrder" HeaderText="交易号">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> --%>
                <asp:TemplateField HeaderText="是否同意报名须知">
                        <ItemTemplate>                          
                           是
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
