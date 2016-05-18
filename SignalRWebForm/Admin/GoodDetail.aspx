<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GoodDetail.aspx.cs" Inherits="Admin_GoodDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>��ϸ(good)-����ά��-ERUN360.COM</title>
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
        
        <!-- ��Ϣ��ʼ -->
        <div id="pageContent">
            <table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse: collapse;">
                <tr bgcolor="#e8e8e8">
                    <td align="center" colspan="6">��Ʒ��ϸ</td>
                </tr>
                <tr>
                    <td align="right" style="width: 120px;">��Ʒ����:</td>
                    <td>
                        <%=good.cName %>(���<%=good.id %>)
                    </td>
                    <td>
                        ״̬��</td>
                    <td>
                       <%=good.iState.ToString()== "0" ? "������": good.iState.ToString() == "1" ? "����":"����"%></td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="right">��ƷͼƬ��</td>
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
                    <td align="right">��Ʒ���ͣ�</td>
                    <td> <%=good.iType.ToString()== "1" ? "���ֶһ�": good.iType.ToString() == "2" ? "�Ź���Ʒ":"��ͨ��Ʒ"%></td>
                    <td align="right">��Ʒ���ԣ�</td>
                    <td> <%=good.iEntity.ToString()== "1" ? "ʵ��":"������Ʒ"%></td>
                    <td> </td>
                    <td> </td>
                </tr>
                <tr>
                    <td align="right">��ʼʱ�䣺</td>
                    <td><%=good.dBeginTime %></td>
                    <td>����ʱ�䣺</td>
                    <td><%=good.dEndTime %></td>
                    <td>�г��۸�</td>
                    <td><%=good.fMarketPrice %>Ԫ</td>
                </tr>
               <tr>
                    <td align="right">ʹ�û��֣�</td>
                    <td><%=good.fScore.ToString()== "1" ? "��-����Ʒ����"+good.iScore+"���ֶһ�"+good.iMoney+"Ԫ": "��"%></td>
                    <td>ʹ��ƴ�ţ�</td>
                    <td><%=good.idTour.ToString()== "1" ? "��": "��-���ܼ�"+good.fSellPrice+"Ԫ"%></td>
                    <td>ʹ�ÿ�棺</td>
                    <td> <%=good.fReserve.ToString()== "1" ? "��": "��"%></td>
                </tr>
                <tr>
                    <td align="right">����������</td>
                    <td><%=good.iBuyNum %>��</td>
                    <td>�ⲿ����:</td>
                    <td><%=good.cLink %></td>
                    <td>��ǰ�������:</td>
                    <td><%=good.iReserve %>��</td>
                </tr>                
                <tr>
                    <td align="right">��Ʒ���ܣ�</td>
                    <td colspan="5">
                        <%=good.cBio %></td>
                </tr>
                 <tr>
                    <td align="right">��������</td>
                    <td  colspan="5">
                        <%=good.cNorm %></td>
                </tr>
                 <tr bgcolor="#e8e8e8">
                    <td align="center" colspan="4">�����ϸ</td>
                     <td align="center" colspan="2">ƴ�Ž�����ϸ</td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:GridView ID="gvReserve" runat="server" AutoGenerateColumns="False" Width="100%">
                            <Columns>
                               <%-- <asp:BoundField DataField="id" HeaderText="���" />--%>
                                <asp:BoundField DataField="cSize" HeaderText="����" />
                                <asp:BoundField DataField="cColor" HeaderText="��ɫ" />
                                <asp:BoundField DataField="cImage" HeaderText="ͼƬ" />                               
                                <asp:BoundField DataField="overage" HeaderText="�����" />
                            </Columns>
                        </asp:GridView>                      
                        </td>
                     <td colspan="2">
                        <asp:GridView ID="gvTour" runat="server" AutoGenerateColumns="False" Width="100%">
                            <Columns>
                                <%--<asp:BoundField DataField="id" HeaderText="���" />--%>
                                <asp:BoundField DataField="iBuyNum" HeaderText="����" />
                                <asp:BoundField DataField="fBuyPrice" HeaderText="�۸�" />                                
                            </Columns>
                        </asp:GridView>
                        </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
