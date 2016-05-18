<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoppingList.aspx.cs" Inherits="Admin_ShoppingList" %>

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
	<div class="conttop">
		<a href="/Admin/PayList.aspx">物品管理首页</a>  >
<a href="/Admin/ShoppingList.aspx">购买记录</a>>
		商品购买记录
	</div>
    </div>
	<table class="gtable">
		<tr>
			<td>商品类型</td>
			<td colspan="2">
                            <asp:RadioButtonList ID="rdotype" runat="server" tabindex="2" OnSelectedIndexChanged="rdotype_SelectedIndexChanged" AutoPostBack="True" RepeatDirection="Horizontal">
                                <asp:ListItem Value="1" Selected="True">积分</asp:ListItem>
                                <asp:ListItem Value="2">拼团</asp:ListItem>
                            </asp:RadioButtonList>
            </td>
		</tr>
		<tr>
			<td><label for="ssname">选择商品：</label></td>
			<td>
                <asp:DropDownList ID="ddlShop" runat="server" OnSelectedIndexChanged="ddlShop_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
            </td>   
            <td><asp:Button ID="btAll" runat="server" OnClick="btAll_Click" Text="全部记录" />
                <asp:Button ID="btdcgm" runat="server" OnClick="btdcgm_Click" Text="导出购买记录" />
            </td>         
		</tr>
	</table>
    </center>
        <div class="table">
            <asp:GridView ID="GVmain" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="#">
                        <ItemTemplate>
                            <%#GVmain.PageIndex * GVmain.PageSize + GVmain.Rows.Count + 1%>
                        </ItemTemplate>
                        <ItemStyle Width="30px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="状态">
                        <ItemTemplate>
                            <%# Eval("iState").ToString() == "1"?"未付款":Eval("iState").ToString() == "2" ? "已付款":"已过期"%>
                        </ItemTemplate>
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="cGoodName" HeaderText="物品名称"></asp:BoundField>
                    <%--<asp:BoundField DataField="idOrder" HeaderText="订单号"></asp:BoundField>
                    <asp:BoundField DataField="idAlipay" HeaderText="交易号"></asp:BoundField>--%>
                    <asp:BoundField DataField="cSize" HeaderText="尺码"></asp:BoundField>
                    <asp:BoundField DataField="cColor" HeaderText="颜色"></asp:BoundField>
                    <asp:BoundField DataField="iBuyNum" HeaderText="数量"></asp:BoundField>
                    <asp:BoundField DataField="idUser" HeaderText="用户ID"></asp:BoundField>
                    <asp:BoundField DataField="cName" HeaderText="姓名"></asp:BoundField>
                     <asp:TemplateField HeaderText="积分">
                        <ItemTemplate>                            
                            <%#  Eval("isUse").ToString() == "1" ? "是": "否"%>  
                        </ItemTemplate>
                        <ItemStyle />
                    </asp:TemplateField>                   
                    <asp:BoundField DataField="iCost" HeaderText="价格"></asp:BoundField>
                    <asp:BoundField DataField="cMobile" HeaderText="联系方式"></asp:BoundField>
                    <asp:BoundField DataField="cMail" HeaderText="邮箱"></asp:BoundField>
                    <asp:TemplateField HeaderText="地址">
                        <ItemTemplate>
                            <%# Eval("cCityname").ToString()%><%# Eval("cAddress").ToString()%>
                        </ItemTemplate>
                        <ItemStyle />
                    </asp:TemplateField>
                     <asp:BoundField DataField="cMark1" HeaderText="备注">
                    <ItemStyle Width="80px" />
                    </asp:BoundField>
                     <asp:TemplateField HeaderText="下单时间">
                        <ItemTemplate>
                            <%#Convert.ToDateTime(Eval("dConfirm").ToString()).ToString("yyyy-MM-dd HH:mm")%>
                        </ItemTemplate>
                     <ItemStyle Width="80px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="付款时间">
                        <ItemTemplate>
                            <%#Eval("dPay").ToString().Length==0?"":Convert.ToDateTime(Eval("dPay").ToString()).ToString("yyyy-MM-dd HH:mm")%>
                        </ItemTemplate>
                     <ItemStyle Width="80px" />
                    </asp:TemplateField>
                </Columns>
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </div>
        <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
            NextPageText="下一页" CssClass="pages"
            CurrentPageButtonClass="cpb" PrevPageText="上一页"
            OnPageChanged="pager_PageChanged" PageSize="50">
        </webdiyer:AspNetPager>
            <asp:GridView ID="GVmain0" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="#">
                        <ItemTemplate>
                            <%#GVmain.PageIndex * GVmain.PageSize + GVmain.Rows.Count + 1%>
                        </ItemTemplate>
                        <ItemStyle Width="30px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="状态">
                        <ItemTemplate>
                            <%# Eval("iState").ToString() == "1"?"未付款":Eval("iState").ToString() == "2" ? "已付款":"已过期"%>
                        </ItemTemplate>
                        <ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="cGoodName" HeaderText="物品名称"></asp:BoundField>
                    <asp:BoundField DataField="idOrder" HeaderText="订单号"></asp:BoundField>
                    <asp:BoundField DataField="idAlipay" HeaderText="交易号"></asp:BoundField>
                    <asp:BoundField DataField="cSize" HeaderText="尺码"></asp:BoundField>
                    <asp:BoundField DataField="cColor" HeaderText="颜色"></asp:BoundField>
                    <asp:BoundField DataField="iBuyNum" HeaderText="数量"></asp:BoundField>
                    <asp:BoundField DataField="idUser" HeaderText="用户ID"></asp:BoundField>
                    <asp:BoundField DataField="cName" HeaderText="姓名"></asp:BoundField>
                     <asp:TemplateField HeaderText="积分">
                        <ItemTemplate>                            
                            <%#  Eval("isUse").ToString() == "1" ? "是": "否"%>  
                        </ItemTemplate>
                        <ItemStyle />
                    </asp:TemplateField>                   
                    <asp:BoundField DataField="iCost" HeaderText="价格"></asp:BoundField>
                    <asp:BoundField DataField="cMobile" HeaderText="联系方式"></asp:BoundField>
                    <asp:BoundField DataField="cMail" HeaderText="邮箱"></asp:BoundField>
                    <asp:TemplateField HeaderText="地址">
                        <ItemTemplate>
                            <%# Eval("cCityname").ToString()%><%# Eval("cAddress").ToString()%>
                        </ItemTemplate>
                        <ItemStyle />
                    </asp:TemplateField>
                     <asp:BoundField DataField="cMark1" HeaderText="备注">
                    <ItemStyle Width="80px" />
                    </asp:BoundField>
                      <asp:TemplateField HeaderText="下单时间">
                        <ItemTemplate>
                            <%#Convert.ToDateTime(Eval("dConfirm").ToString()).ToString("yyyy-MM-dd HH:mm")%>
                        </ItemTemplate>
                     <ItemStyle Width="80px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="付款时间">
                        <ItemTemplate>
                            <%#Eval("dPay").ToString().Length==0?"":Convert.ToDateTime(Eval("dPay").ToString()).ToString("yyyy-MM-dd HH:mm")%>
                        </ItemTemplate>
                     <ItemStyle Width="80px" />
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
