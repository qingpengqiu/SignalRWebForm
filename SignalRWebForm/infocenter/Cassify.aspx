<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cassify.aspx.cs" Inherits="infocenter_Cassify" %>

<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../Html/css/new-classify.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap-validation.min.js"></script>
</head>
<body>
    <form id="Form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <%--   <div id="show">
        </div>--%>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Repeater ID="rptClassify" runat="server" OnItemDataBound="rptClassify_ItemDataBound">
                    <HeaderTemplate>
                        <table>
                            <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>分类名称</th>
                                    <th>博客数量</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.ItemIndex + 1%></td>
                            <td><%#Eval("cTitle")%></td>
                            <td><%#Eval("iNumber")%></td>
                            <td>
                            <asp:LinkButton ID="delete" runat="server" Text="删除" CommandArgument='<%#Eval("id") %>'   OnClick="delete_Click"></asp:LinkButton>
                                <%-- <%#int.Parse(Eval("iNumber").ToString())==0?"<a>删除</a>":""%>--%>
                            </td>
                            <%--<td><a href="<%#Eval("id")%>">删除</a></td>--%>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btGroup" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <div class="newclassify">
            <label for="title">新建分类</label>
            <input type="text" name="title" id="cTitle" runat="server" value="" tabindex="1" class="input-xlarge" />
            <%--<button type="submit" class="btn" id="submit">保存</button>--%>
            <%--<input id="Button1" type="button" value="click" onclick="bclick();" />--%>

            <asp:Button ID="btGroup" runat="server" class="btn" OnClick="btGroup_Click" />
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div id="tipfl" class="tipfl" runat="server"></div>
 </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btGroup" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        </div>
    </form>    
</body>
</html>
