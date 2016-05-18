<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceEdit.aspx.cs" Inherits="Competetion_RaceEdit" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<script type="text/javascript" src="/Html/js/My97DatePicker/WdatePicker.js"></script>
<style>
    body{background: #f6f6f6}
    .fbli {min-height: 29px;}
</style>
    <div class="banner">
        <div class="mine">
            <h1><%=title %></h1>
            <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
        </div>
    </div>
    <form id="form1" runat="server">
        <div class="tbody">
            <div class="mine">
                <ERUN360:bmnav runat="server" ID="bmnav" />
                <div class="tbodyBox">
                    <div class="event this clearfix">
                        <div class="eqma">
                            <div class="eqmal">
                                <a class="eqmaa eqmajd" href="RaceCom.aspx?sid=<%=idCompete %>">��Ŀ����<i></i></a>
                            </div>
                            <div class="eqmar am-form ">
                                <div class="fbtitle">�����Ŀ</div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>��Ŀ���ƣ�</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="item" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 185px;">
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>�ϼ�ʱ�䣺</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="dJoinBegin" runat="server" class="am-form-field am-radius fbftitle" style="width: 185px" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm'})" />-<input id="dJoinEnd" runat="server" class="am-form-field am-radius fbftitle" style="width: 185px" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm'})" />
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>��Ŀ���ã�</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="price" type="text" class="am-form-field am-radius fb82" placeholder="" runat="server">Ԫ(�����)
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>���</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="number" type="text" class="am-form-field am-radius fb82" placeholder="" runat="server">��
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>��ע��</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="bz" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 200px;">
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>�ṩ��װ��</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbfz" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="7">
                                                <asp:ListItem Value="1">��</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>�ṩ��Ь��</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbpx" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="7">
                                                <asp:ListItem Value="1">��</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>��Ҫ���ϸ�֤��</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbhgz" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="7">
                                                <asp:ListItem Value="1">��</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>�Ƿ���Ҫ��ˣ�</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbsh" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="7">
                                                <asp:ListItem Value="1">��</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>���</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbType" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList" TabIndex="10" OnSelectedIndexChanged="rdbType_SelectedIndexChanged" AutoPostBack="True">
                                                <asp:ListItem Value="1" Selected="True">����</asp:ListItem>
                                                <asp:ListItem Value="2">�⼮</asp:ListItem>
                                                <asp:ListItem Value="3">���</asp:ListItem>
                                                <asp:ListItem Value="4">�Ŷ�</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div id="idNum" runat="server" visible="false">
                                        <div class="fbli">
                                            <div class="fblil">
                                                <label>���������</label>
                                            </div>
                                            <div class="fblir">
                                                <input type="text" name="idNumber" id="idNumber" runat="server" class="am-form-field am-radius fb82" style="width: 215px;" /><label for="idNumber">��</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>���ֶһ���</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="iScore" type="text" class="am-form-field am-radius fb82" placeholder="" runat="server"><label>�һ���</label><input type="text" runat="server" tabindex="4" id="iMoney" maxlength="9" class="am-form-field am-radius fb82" /><label>Ԫ</label>��1.���ʹ�û���ֻ����д���֣��һ�Ǯ��Ϊ0��2.���ֵֿ�Ǯ��������д���ֺͶһ�Ǯ����3.���ֺͶһ�Ǯ����Ϊ0��Ϊ��ʹ�û��֣�
                                        </div>
                                    </div>
                                            <asp:Repeater ID="rptExt" runat="server">
                                                <HeaderTemplate>
                                                    <table class="maxm">
                                                        <tr>
                                                            <td>������չ˵��</td>
                                                            <td>Ӣ����չ˵��</td>
                                                            <td>��չ����</td>
                                                            <td>���λ��</td>
                                                            <td>���ı�ע</td>
                                                            <td>Ӣ�ı�ע</td>
                                                            <td>����</td>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "cnName")%></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "enName")%></td>
                                                        <td>
                                                            <%#  Eval("data_type").ToString() == "1" ? "�����ϴ�": Eval("data_type").ToString() == "2" ? "�ı���ע":Eval("data_type").ToString() == "3" ? "ѡ����":""%>
                                                        </td>
                                                        <td>
                                                            <%#  Eval("sales_field").ToString() == "cRemark2" ? "λ��1": Eval("sales_field").ToString() == "cRemark3" ? "λ��2":Eval("sales_field").ToString() == "cRemark4" ? "λ��3":""%>
                                                        </td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "cnTip")%></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "enTip")%></td>
                                                        <td><a href='<%# "RaceExt.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+idCompete +"&iditem="+DataBinder.Eval(Container.DataItem, "iditem")%>'>�༭</a>

                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <%--AlternatingItemTemplate������������е���һ�����--%>
                                                <AlternatingItemTemplate>
                                                    <tr bgcolor="#e8e8e8">
                                                        <td><%# DataBinder.Eval(Container.DataItem, "cnName")%></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "enName")%></td>
                                                        <td>
                                                            <%#  Eval("data_type").ToString() == "1" ? "�����ϴ�": Eval("data_type").ToString() == "2" ? "�ı���ע":Eval("data_type").ToString() == "3" ? "�Ƿ�":""%>
                                                        </td>
                                                        <td>
                                                            <%#  Eval("sales_field").ToString() == "cRemark2" ? "λ��1": Eval("sales_field").ToString() == "cRemark3" ? "λ��2":Eval("sales_field").ToString() == "cRemark4" ? "λ��3":""%>
                                                        </td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "cnTip")%></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "enTip")%></td>
                                                        <td><a href='<%# "RaceExt.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+idCompete +"&iditem="+DataBinder.Eval(Container.DataItem, "iditem")%>'>�༭</a>

                                                        </td>
                                                    </tr>
                                                </AlternatingItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            <label><a href="javascript:void(0)" class="add-records">+�����չ�ֶ�</a></label>
                                    <div id="kzzd">
                                    </div>
                                    <div class="savefb">
                                            <asp:Button ID="Btnsubmit" runat="server" class="fkbuttom" Text="����" OnClick="Btnsubmit_Click"></asp:Button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </form>
    <script type="text/javascript">
        var num = 0;
        $(".add-records").click(function () {
            $("#kzzd").append("<div class=\"fbli\"><div class=\"fblil\"><label>��չ���ͣ�</label></div><div class=\"fblir\"><select name=\"ddlType" + num + "\" id=\"ddlType" + num + "\" tabindex=\"3\" style=\"width: 185px;\" ><option value=\"1\">�����ϴ�</option><option selected=\"selected\" value=\"2\">�ı���ע</option>	<option value=\"3\">ѡ����</option></select></div></div>      <div class=\"fbli\"><div class=\"fblil\"><label>������չ˵����</label></div><div class=\"fblir\"> <input id=\"cnName" + num + "\" name=\"cnName" + num + "\" type=\"text\" class=\"am-form-field am-radius fb82\"  style=\"width: 185px;\"/></div></div>    <div class=\"fbli\"><div class=\"fblil\"><label>Ӣ����չ˵����</label></div><div class=\"fblir\"><input id=\"enName" + num + "\" name=\"enName" + num + "\" class=\"am-form-field am-radius fbftitle\" style=\"width: 185px\" type=\"text\"/></div></div>               <div class=\"fbli\"><div class=\"fblil\"><label>���λ�ã�</label></div><div class=\"fblir\"><select name=\"ddlfield" + num + "\" id=\"ddlfield" + num + "\"  style=\"width: 185px;\">	<option value=\"cECG\">λ��1</option>	<option value=\"cFinished\">λ��2</option>	<option value=\"cMake\">λ��3</option><option value=\"cMake1\">λ��4</option><option value=\"cMake2\">λ��5</option> </select>  </div></div>                   <div class=\"fbli\"><div class=\"fblil\"><label>���ı�ע��</label></div><div class=\"fblir\"><input name=\"tipcnName" + num + "\" type=\"text\" id=\"tipcnName" + num + "\" class=\"am-form-field am-radius fb82\"  style=\"width: 185px;\" ></div></div>                             <div class=\"fbli\"><div class=\"fblil\"><label>Ӣ�ı�ע��</label></div><div class=\"fblir\"><input id=\"tipenName" + num + "\" name=\"tipenName" + num + "\" class=\"am-form-field am-radius fbftitle\" style=\"width: 185px\" type=\"text\"/></div></div>");

            num++;
        });
    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />