<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceRecord.aspx.cs" Inherits="Admin_RaceRecord" %>
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
			<td>选择赛事：<asp:DropDownList ID="DDLRace" runat="server" OnSelectedIndexChanged="DDLRace_SelectedIndexChanged"  AutoPostBack="true">
                </asp:DropDownList>
            </td>
		</tr>
		<tr>
			<td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" ></asp:RadioButtonList>
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
                            <td>尺码</td>
                            <td>昵称</td>
                            <td>姓名</td>
                            <td>性别</td>
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
                        <td><%# Eval("iState").ToString() == "0" ? "待审核" : Eval("iState").ToString() == "1"?"未付款":Eval("iState").ToString() == "2" ? "已付款":Eval("iState").ToString() == "3" ? "已组队":"已过期"%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cCloth")%></td>
                        <td> <%# GetNick(Eval("idUser").ToString())%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>
                        <td><%# Eval("idGender").ToString() == "0" ? "男" :"女"%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cNationID")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMobile")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMail")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cCityname")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cRemark1")%></td>
                        <td>
                          <%#Eval("cHealthUrl").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cHealthUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cOrigin").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cOrigin").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cMake").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cMake").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cRemark2").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cRemark2").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                            <%#Eval("cRemark3").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cRemark3").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cRemark4").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cRemark4").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                        </td>
                        <td><a href='<%# "RaceRecordEdit.aspx?idRace="+idRace+"&idItem="+idItem+"&id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_self">编辑</a></td>
                        <td><%# Eval("cRemark5").ToString() == "1" ? "是" :"否"%></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr bgcolor="#e8e8e8">
                        <td>
                            <a name='a<%# Eval("id")%>'></a>
                            <%# Container.ItemIndex + 1%>
                            <%--<%# DataBinder.Eval(Container.DataItem, "id")%>--%>
                        </td>
                        <td><%# Eval("iState").ToString() == "0" ? "待审核" : Eval("iState").ToString() == "1"?"未付款":Eval("iState").ToString() == "2" ? "已付款":Eval("iState").ToString() == "3" ? "已组队":"已过期"%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cCloth")%></td>
                        <td> <%# GetNick(Eval("idUser").ToString())%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>
                        <td><%# Eval("idGender").ToString() == "0" ? "男" :"女"%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cNationID")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMobile")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMail")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cCityname")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cRemark1")%></td>
                        <td>
                             <%#Eval("cHealthUrl").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cHealthUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cOrigin").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cOrigin").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cMake").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cMake").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cRemark2").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cRemark2").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                            <%#Eval("cRemark3").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cRemark3").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cRemark4").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cRemark4").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                        </td>
                        <td><a href='<%# "RaceRecordEdit.aspx?idRace="+idRace+"&idItem="+idItem+"&id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_self">编辑</a></td>
                        <td><%# Eval("cRemark5").ToString() == "1" ? "是" :"否"%></td>
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
                 <asp:BoundField DataField="cGJ" HeaderText="国籍">                  
                </asp:BoundField>  
                <asp:BoundField DataField="iCost" HeaderText="价格">                  
                </asp:BoundField>                    
                 <asp:BoundField DataField="cRemark2" HeaderText="位置1">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cRemark3" HeaderText="位置2">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="cRemark4" HeaderText="位置3">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="cShoe" HeaderText="鞋号/护照签发地点">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:BoundField DataField="dPay" HeaderText="付款时间">
                         </asp:BoundField>
                <asp:BoundField DataField="idUser" HeaderText="用户ID">
                         </asp:BoundField>
                 <asp:TemplateField HeaderText="附属产品">
                        <ItemTemplate>                          
                              <%#GetAnnexLog(Eval("idSignUp").ToString(),Eval("idUser").ToString()) %>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>
                <asp:BoundField DataField="cRemark1" HeaderText="审核批注">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                 <asp:TemplateField HeaderText="使用积分">
                        <ItemTemplate>                          
                             <%# Eval("cRemark5").ToString() == "1" ? "是" :"否"%>
                        </ItemTemplate>   
                        <ItemStyle Width="80px"></ItemStyle>                    
                    </asp:TemplateField>
                 <asp:BoundField DataField="idOrder" HeaderText="订单号">
                    <ItemStyle Width="150px"></ItemStyle>
                </asp:BoundField> 
                <asp:BoundField DataField="idAlipay" HeaderText="交易号">
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
             </center>
    </form>
</body>
</html>
