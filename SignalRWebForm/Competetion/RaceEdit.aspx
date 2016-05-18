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
                                <a class="eqmaa eqmajd" href="RaceCom.aspx?sid=<%=idCompete %>">项目管理<i></i></a>
                            </div>
                            <div class="eqmar am-form ">
                                <div class="fbtitle">添加项目</div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>项目名称：</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="item" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 185px;">
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>上架时间：</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="dJoinBegin" runat="server" class="am-form-field am-radius fbftitle" style="width: 185px" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm'})" />-<input id="dJoinEnd" runat="server" class="am-form-field am-radius fbftitle" style="width: 185px" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm'})" />
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>项目费用：</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="price" type="text" class="am-form-field am-radius fb82" placeholder="" runat="server">元(人民币)
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>名额：</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="number" type="text" class="am-form-field am-radius fb82" placeholder="" runat="server">人
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>备注：</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="bz" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 200px;">
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>提供服装：</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbfz" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="7">
                                                <asp:ListItem Value="1">是</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">否</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>提供跑鞋：</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbpx" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="7">
                                                <asp:ListItem Value="1">是</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">否</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>需要体检合格证：</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbhgz" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="7">
                                                <asp:ListItem Value="1">是</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">否</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>是否需要审核：</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbsh" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="7">
                                                <asp:ListItem Value="1">是</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">否</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>类别：</label>
                                        </div>
                                        <div class="fblir">
                                            <asp:RadioButtonList ID="rdbType" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList" TabIndex="10" OnSelectedIndexChanged="rdbType_SelectedIndexChanged" AutoPostBack="True">
                                                <asp:ListItem Value="1" Selected="True">国内</asp:ListItem>
                                                <asp:ListItem Value="2">外籍</asp:ListItem>
                                                <asp:ListItem Value="3">组队</asp:ListItem>
                                                <asp:ListItem Value="4">团队</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div id="idNum" runat="server" visible="false">
                                        <div class="fbli">
                                            <div class="fblil">
                                                <label>组队人数：</label>
                                            </div>
                                            <div class="fblir">
                                                <input type="text" name="idNumber" id="idNumber" runat="server" class="am-form-field am-radius fb82" style="width: 215px;" /><label for="idNumber">人</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="fbli">
                                        <div class="fblil">
                                            <label>积分兑换：</label>
                                        </div>
                                        <div class="fblir">
                                            <input id="iScore" type="text" class="am-form-field am-radius fb82" placeholder="" runat="server"><label>兑换：</label><input type="text" runat="server" tabindex="4" id="iMoney" maxlength="9" class="am-form-field am-radius fb82" /><label>元</label>（1.最多使用积分只需填写积分，兑换钱数为0；2.积分抵扣钱数必须填写积分和兑换钱数；3.积分和兑换钱数都为0则为不使用积分）
                                        </div>
                                    </div>
                                            <asp:Repeater ID="rptExt" runat="server">
                                                <HeaderTemplate>
                                                    <table class="maxm">
                                                        <tr>
                                                            <td>中文扩展说明</td>
                                                            <td>英文扩展说明</td>
                                                            <td>扩展类型</td>
                                                            <td>存放位置</td>
                                                            <td>中文备注</td>
                                                            <td>英文备注</td>
                                                            <td>操作</td>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "cnName")%></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "enName")%></td>
                                                        <td>
                                                            <%#  Eval("data_type").ToString() == "1" ? "附件上传": Eval("data_type").ToString() == "2" ? "文本备注":Eval("data_type").ToString() == "3" ? "选择项":""%>
                                                        </td>
                                                        <td>
                                                            <%#  Eval("sales_field").ToString() == "cRemark2" ? "位置1": Eval("sales_field").ToString() == "cRemark3" ? "位置2":Eval("sales_field").ToString() == "cRemark4" ? "位置3":""%>
                                                        </td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "cnTip")%></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "enTip")%></td>
                                                        <td><a href='<%# "RaceExt.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+idCompete +"&iditem="+DataBinder.Eval(Container.DataItem, "iditem")%>'>编辑</a>

                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <%--AlternatingItemTemplate描述交替输出行的另一种外观--%>
                                                <AlternatingItemTemplate>
                                                    <tr bgcolor="#e8e8e8">
                                                        <td><%# DataBinder.Eval(Container.DataItem, "cnName")%></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "enName")%></td>
                                                        <td>
                                                            <%#  Eval("data_type").ToString() == "1" ? "附件上传": Eval("data_type").ToString() == "2" ? "文本备注":Eval("data_type").ToString() == "3" ? "是否":""%>
                                                        </td>
                                                        <td>
                                                            <%#  Eval("sales_field").ToString() == "cRemark2" ? "位置1": Eval("sales_field").ToString() == "cRemark3" ? "位置2":Eval("sales_field").ToString() == "cRemark4" ? "位置3":""%>
                                                        </td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "cnTip")%></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "enTip")%></td>
                                                        <td><a href='<%# "RaceExt.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+idCompete +"&iditem="+DataBinder.Eval(Container.DataItem, "iditem")%>'>编辑</a>

                                                        </td>
                                                    </tr>
                                                </AlternatingItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            <label><a href="javascript:void(0)" class="add-records">+添加扩展字段</a></label>
                                    <div id="kzzd">
                                    </div>
                                    <div class="savefb">
                                            <asp:Button ID="Btnsubmit" runat="server" class="fkbuttom" Text="保存" OnClick="Btnsubmit_Click"></asp:Button>
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
            $("#kzzd").append("<div class=\"fbli\"><div class=\"fblil\"><label>扩展类型：</label></div><div class=\"fblir\"><select name=\"ddlType" + num + "\" id=\"ddlType" + num + "\" tabindex=\"3\" style=\"width: 185px;\" ><option value=\"1\">附件上传</option><option selected=\"selected\" value=\"2\">文本备注</option>	<option value=\"3\">选择项</option></select></div></div>      <div class=\"fbli\"><div class=\"fblil\"><label>中文扩展说明：</label></div><div class=\"fblir\"> <input id=\"cnName" + num + "\" name=\"cnName" + num + "\" type=\"text\" class=\"am-form-field am-radius fb82\"  style=\"width: 185px;\"/></div></div>    <div class=\"fbli\"><div class=\"fblil\"><label>英文扩展说明：</label></div><div class=\"fblir\"><input id=\"enName" + num + "\" name=\"enName" + num + "\" class=\"am-form-field am-radius fbftitle\" style=\"width: 185px\" type=\"text\"/></div></div>               <div class=\"fbli\"><div class=\"fblil\"><label>存放位置：</label></div><div class=\"fblir\"><select name=\"ddlfield" + num + "\" id=\"ddlfield" + num + "\"  style=\"width: 185px;\">	<option value=\"cECG\">位置1</option>	<option value=\"cFinished\">位置2</option>	<option value=\"cMake\">位置3</option><option value=\"cMake1\">位置4</option><option value=\"cMake2\">位置5</option> </select>  </div></div>                   <div class=\"fbli\"><div class=\"fblil\"><label>中文备注：</label></div><div class=\"fblir\"><input name=\"tipcnName" + num + "\" type=\"text\" id=\"tipcnName" + num + "\" class=\"am-form-field am-radius fb82\"  style=\"width: 185px;\" ></div></div>                             <div class=\"fbli\"><div class=\"fblil\"><label>英文备注：</label></div><div class=\"fblir\"><input id=\"tipenName" + num + "\" name=\"tipenName" + num + "\" class=\"am-form-field am-radius fbftitle\" style=\"width: 185px\" type=\"text\"/></div></div>");

            num++;
        });
    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />