<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Navigation.aspx.cs" Inherits="Competetion_Navigation" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
	<div class="banner">
	     <div class="mine"><h1><%=title %></h1>
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
                			<%--<a class="eqmaa eqmajd" href="Navigationlb.aspx?sid=<%=sid %>">导航配置<i></i></a>--%>
                		</div>
                		<div class="eqmar am-form ">
                			<div class="fbtitle">导航配置
                            <div class="fbli" style="display:none;">
                				<div class="fblil"><label>选择赛事：</label></div>
                                <div class="fblir">
                                   <asp:DropDownList ID="DDLRace" runat="server" AutoPostBack="true" style="width: 200px;"></asp:DropDownList></div>
                			</div>
                			<div class="fbli">
                				<div class="fblil"><label>导航名称：</label></div>
                                <div class="fblir"><asp:CheckBoxList ID="cbxFscp" runat="server" RepeatColumns="4"></asp:CheckBoxList>	</div>
                			</div>
                			<div class="savefb"><asp:Button ID="but_save" runat="server"  class="fkbuttom" Text="保存" OnClick="but_save_Click" ></asp:Button></div>
                		</div>
                	</div>
                </div>
            </div>
        </div>
    </div>
        </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />