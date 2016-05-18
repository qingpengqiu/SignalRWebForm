<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GoodDetail.aspx.cs" Inherits="Admin_GoodDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>详细(good)-数据维护-ERUN360.COM</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
       <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
        <script language="javascript" src="/Common/jCheck.js"></script>
        <script language="javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <style type="text/css">
        .auto-style1 {
            height: 21px;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        
        <!-- 信息开始 -->
        <div id="pageContent">
            <table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse: collapse;">
                <tr bgcolor="#e8e8e8">
                    <td align="center" colspan="6">商品明细</td>
                </tr>
                <tr>
                    <td align="right" style="width: 120px;">物品名称:</td>
                    <td>
                        <%=good.cName %>(编号<%=good.id %>)
                    </td>
                    <td>
                        状态：</td>
                    <td>
                       <%=good.iState.ToString()== "0" ? "待发布": good.iState.ToString() == "1" ? "发布":"禁用"%></td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="right">物品图片：</td>
                    <td>
                        <img src=" <%=good.cImage %>" width="60" height="60"></td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="right">物品类型：</td>
                    <td> <%=good.iType.ToString()== "1" ? "积分兑换": good.iType.ToString() == "2" ? "团购商品":"普通商品"%></td>
                    <td align="right">物品属性：</td>
                    <td> <%=good.iEntity.ToString()== "1" ? "实物":"虚拟商品"%></td>
                    <td> </td>
                    <td> </td>
                </tr>
                <tr>
                    <td align="right">开始时间：</td>
                    <td><%=good.dBeginTime %></td>
                    <td>结束时间：</td>
                    <td><%=good.dEndTime %></td>
                    <td>市场价格：</td>
                    <td><%=good.fMarketPrice %>元</td>
                </tr>
               <tr>
                    <td align="right">使用积分：</td>
                    <td><%=good.fScore.ToString()== "1" ? "是-本商品允许"+good.iScore+"积分兑换"+good.iMoney+"元": "否"%></td>
                    <td>使用拼团：</td>
                    <td><%=good.idTour.ToString()== "1" ? "是": "否-益跑价"+good.fSellPrice+"元"%></td>
                    <td>使用库存：</td>
                    <td> <%=good.fReserve.ToString()== "1" ? "是": "否"%></td>
                </tr>
                <tr>
                    <td align="right">购买人数：</td>
                    <td><%=good.iBuyNum %>人</td>
                    <td>外部链接:</td>
                    <td><%=good.cLink %></td>
                    <td>当前库存数量:</td>
                    <td><%=good.iReserve %>件</td>
                </tr>                
                <tr>
                    <td align="right">产品介绍：</td>
                    <td colspan="5">
                        <%=good.cBio %></td>
                </tr>
                 <tr>
                    <td align="right">规格参数：</td>
                    <td  colspan="5">
                        <%=good.cNorm %></td>
                </tr>
                 <tr bgcolor="#e8e8e8">
                    <td align="center" colspan="4">库存明细</td>
                     <td align="center" colspan="2">拼团阶梯明细</td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:GridView ID="gvReserve" runat="server" AutoGenerateColumns="False" Width="100%">
                            <Columns>
                               <%-- <asp:BoundField DataField="id" HeaderText="编号" />--%>
                                <asp:BoundField DataField="cSize" HeaderText="尺码" />
                                <asp:BoundField DataField="cColor" HeaderText="颜色" />
                                <asp:BoundField DataField="cImage" HeaderText="图片" />                               
                                <asp:BoundField DataField="overage" HeaderText="库存量" />
                            </Columns>
                        </asp:GridView>                      
                        </td>
                     <td colspan="2">
                        <asp:GridView ID="gvTour" runat="server" AutoGenerateColumns="False" Width="100%">
                            <Columns>
                                <%--<asp:BoundField DataField="id" HeaderText="编号" />--%>
                                <asp:BoundField DataField="iBuyNum" HeaderText="人数" />
                                <asp:BoundField DataField="fBuyPrice" HeaderText="价格" />                                
                            </Columns>
                        </asp:GridView>
                        </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
