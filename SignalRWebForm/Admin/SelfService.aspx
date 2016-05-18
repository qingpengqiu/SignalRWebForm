<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelfService.aspx.cs" Inherits="Admin_SelfService" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
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
        width: 80px;
        margin-bottom: 0px;
    }

    #GVmain tr {
        border-bottom: 1px dotted #ccc;
    }

        #GVmain tr:first-child {
            border: 0;
        }
</style>
<div class="cont">
		<a href="/" >首页</a>  >
<a href="/Admin/RaceList.aspx">赛事首页</a>>
		自主赛事申请资料
	</div>

	<table class="gtable">
		<tr>
			<td>商品类型</td>
			<td colspan="2">
                            <asp:RadioButtonList ID="rdotype" runat="server" tabindex="2" OnSelectedIndexChanged="rdotype_SelectedIndexChanged" AutoPostBack="True" RepeatDirection="Horizontal">
                                <asp:ListItem Value="0" Selected="True">个人申请</asp:ListItem>
                                <asp:ListItem Value="1">公司申请</asp:ListItem>
                            </asp:RadioButtonList>
            </td>
		</tr>
	</table>
    </center>
        <div class="table">
            <asp:GridView ID="gvPerson" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="#">
                        <ItemTemplate>
                            <%#gvPerson.PageIndex * gvPerson.PageSize + gvPerson.Rows.Count + 1%>
                        </ItemTemplate>
                        <ItemStyle Width="30px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="状态">
                        <ItemTemplate>
                            <%# Eval("iStatus").ToString() == "1"?"待审核":Eval("iStatus").ToString() == "2" ? "已通过":"未提交"%>
                        </ItemTemplate>
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="cName" HeaderText="名称"></asp:BoundField>
                   <%-- <asp:BoundField DataField="cAddress" HeaderText="地址"></asp:BoundField>--%>
                    <asp:BoundField DataField="cMobile" HeaderText="联系方式"></asp:BoundField>
                    <asp:BoundField DataField="cMail" HeaderText="邮箱"></asp:BoundField>
                    <asp:TemplateField HeaderText="证件类型">
                        <ItemTemplate>
                            <%# Eval("idNationIDType").ToString() == "1" ? "身份证" : Eval("idNationIDType").ToString() == "2"?"军官证":Eval("idNationIDType").ToString() == "3" ? "户口本":Eval("idNationIDType").ToString() == "4" ? "其他":"未选择"%>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="cNationID" HeaderText="证件号码"></asp:BoundField>
                    <asp:TemplateField HeaderText="证件">                   
                        <ItemTemplate>                           
                            <%#Eval("cFaceUrl").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cFaceUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cBackUrl").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cBackUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                        </ItemTemplate>
                        <ItemStyle Width="60px"></ItemStyle>
                    </asp:TemplateField>
                   <%-- <asp:BoundField DataField="idUser" HeaderText="用户ID"></asp:BoundField>--%>
                    <asp:BoundField DataField="cRaceTitle" HeaderText="赛事名称"></asp:BoundField>
                    <asp:BoundField DataField="dRacetime" HeaderText="时间"></asp:BoundField>
                    <asp:BoundField DataField="cRaceAddress" HeaderText="地点"></asp:BoundField>
                    <asp:BoundField DataField="cStyle" HeaderText="类型"></asp:BoundField>

                   <%-- <asp:BoundField DataField="iScale" HeaderText="规模"></asp:BoundField>
                    <asp:BoundField DataField="cRacepack" HeaderText="参赛包"></asp:BoundField>
                    <asp:BoundField DataField="tRegulation" HeaderText="规程"></asp:BoundField>--%>
                     <asp:TemplateField HeaderText="图片">                   
                        <ItemTemplate>                           
                            <%#Eval("cSRacePicUrl").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cSRacePicUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                        </ItemTemplate>
                        <ItemStyle Width="60px"></ItemStyle>
                    </asp:TemplateField>
                  <%--  <asp:BoundField DataField="cMark" HeaderText="备注说明"></asp:BoundField>--%>
                     <asp:TemplateField HeaderText="详情">                   
                        <ItemTemplate>
                            <%#"<a target='_blank' href='SelfServiceDetail.aspx?id="+Eval("id").ToString()+"'>详情</a>" %>
                        </ItemTemplate>
                        
                        <ItemStyle Width="60px"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
            <asp:GridView ID="gvCompany" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="#">
                        <ItemTemplate>
                            <%#gvCompany.PageIndex * gvCompany.PageSize + gvCompany.Rows.Count + 1%>
                        </ItemTemplate>
                        <ItemStyle Width="30px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="状态">
                        <ItemTemplate>
                            <%# Eval("iStatus").ToString() == "1"?"待审核":Eval("iStatus").ToString() == "2" ? "已通过":"未提交"%>
                        </ItemTemplate>
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="cName" HeaderText="名称"></asp:BoundField>
                    <%--<asp:BoundField DataField="cAddress" HeaderText="住所"></asp:BoundField>
                    <asp:BoundField DataField="cType" HeaderText="公司类型"></asp:BoundField>
                    <asp:BoundField DataField="cScope" HeaderText="经营范围"></asp:BoundField>--%>
                    <asp:BoundField DataField="cTelephone" HeaderText="座机"></asp:BoundField>
                    <asp:BoundField DataField="cHeader" HeaderText="负责人"></asp:BoundField>


                    <asp:BoundField DataField="cMobile" HeaderText="联系方式"></asp:BoundField>
                    <asp:TemplateField HeaderText="证件">                   
                        <ItemTemplate>                           
                            <%#Eval("cFaceUrl").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cFaceUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                             <%#Eval("cBackUrl").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cBackUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                        </ItemTemplate>
                        <ItemStyle Width="60px"></ItemStyle>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="idUser" HeaderText="用户ID"></asp:BoundField>--%>
                    <asp:BoundField DataField="cRaceTitle" HeaderText="赛事名称"></asp:BoundField>
                    <asp:BoundField DataField="dRacetime" HeaderText="时间"></asp:BoundField>
                    <asp:BoundField DataField="cRaceAddress" HeaderText="地点"></asp:BoundField>
                    <asp:BoundField DataField="cStyle" HeaderText="类型"></asp:BoundField>

                   <%-- <asp:BoundField DataField="iScale" HeaderText="规模"></asp:BoundField>
                    <asp:BoundField DataField="cRacepack" HeaderText="参赛包"></asp:BoundField>
                    <asp:BoundField DataField="tRegulation" HeaderText="规程"></asp:BoundField>--%>
                     <asp:TemplateField HeaderText="图片">                   
                        <ItemTemplate>                           
                            <%#Eval("cSRacePicUrl").ToString().IndexOf(GetDir(Eval("idUser").ToString()))==-1?"":@"<a target='_blank' href='"+HostInfo.imgName+"/Utility/uploads/"+Eval("cSRacePicUrl").ToString()+"'><img src='/Html/images/img_icon.png'/></a>"%> 
                        </ItemTemplate>
                        <ItemStyle Width="60px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="cMark" HeaderText="备注说明"></asp:BoundField>
                     <asp:TemplateField HeaderText="详情">                   
                        <ItemTemplate>
                            <%#"<a target='_blank' href='SelfServiceDetail2.aspx?id="+Eval("id").ToString()+"'>详情</a>" %>
                        </ItemTemplate>
                        
                        <ItemStyle Width="60px"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </div>
        <%-- <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
            NextPageText="下一页" CssClass="pages"
            CurrentPageButtonClass="cpb" PrevPageText="上一页"
            OnPageChanged="pager_PageChanged" PageSize="50">
        </webdiyer:AspNetPager>--%>
    </form>
</body>
</html>
