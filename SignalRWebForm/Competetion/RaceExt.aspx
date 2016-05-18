<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceExt.aspx.cs" Inherits="Admin_RaceExt" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
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
                                <%--<a class="eqmaa eqmajd" href=""><i></i></a>--%>
                            </div>
                            <div class="eqmar am-form ">
                                <div class="fbtitle">
                                    �༭��չ�ֶ�

                                <div class="fbli">
                                    <div class="fblil">
                                        <label>�������ƣ�</label></div>
                                    <div class="fblir">
                                        <input type="text" id="ssmc" readonly tabindex="1" runat="server" class="am-form-field am-radius fbftitle" />

                                    </div>
                                </div>

                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>��Ŀ���ƣ�</label></div>
                                        <div class="fblir">
                                            <input type="text" id="item" readonly runat="server" tabindex="2" class="am-form-field am-radius fbftitle" />

                                        </div>
                                    </div>

                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>��չ���ͣ�</label></div>
                                        <div class="fblir">
                                            <asp:DropDownList ID="ddlType" runat="server" TabIndex="3" class="am-form-field am-radius fbftitle">
                                                <asp:ListItem Value="1" Selected="True">�����ϴ�</asp:ListItem>
                                                <asp:ListItem Value="2">�ı���ע</asp:ListItem>
                                                <asp:ListItem Value="3">ѡ����</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                    </div>

                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>������չ˵����</label></div>
                                        <div class="fblir">
                                            <input type="text" id="cnName" runat="server" tabindex="4" maxlength="32" class="am-form-field am-radius fbftitle" />

                                        </div>
                                    </div>

                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>Ӣ����չ˵����</label></div>
                                        <div class="fblir">
                                            <input type="text" id="enName" runat="server" tabindex="5" maxlength="32" class="am-form-field am-radius fbftitle" />

                                        </div>
                                    </div>


                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>���λ�ã�</label></div>
                                        <div class="fblir">
                                            <asp:DropDownList ID="ddlfield" runat="server" TabIndex="6" class="am-form-field am-radius fbftitle">
                                                <asp:ListItem Value="cECG" Selected="True">λ��1</asp:ListItem>
                                                <asp:ListItem Value="cFinished">λ��2</asp:ListItem>
                                                <asp:ListItem Value="cMake">λ��3</asp:ListItem>
                                                <asp:ListItem Value="cMake1">λ��4</asp:ListItem>
                                                <asp:ListItem Value="cMake2">λ��5</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>���ı�ע��</label></div>
                                        <div class="fblir">
                                            <input type="text" id="tipcnName" runat="server" tabindex="7" maxlength="25" class="am-form-field am-radius fbftitle" />

                                        </div>
                                    </div>

                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>Ӣ�ı�ע��</label></div>
                                        <div class="fblir">
                                            <input type="text" id="tipenName" runat="server" tabindex="8" maxlength="25" class="am-form-field am-radius fbftitle" />

                                        </div>
                                    </div>


                                    <div class="savefb">
                                        <asp:Button ID="but_save" runat="server" class="fkbuttom" Text="����" OnClick="Btnsubmit_Click"></asp:Button></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />