<%@ Page Language="C#" AutoEventWireup="true" CodeFile="insertbook.aspx.cs" Inherits="Competetion_insertbook" %>
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
                			<%--<a class="eqmaa eqmajd" href="">赛记<i></i></a>--%>
                		</div>
                		<div class="eqmar am-form ">
                			<div class="fbtitle">关联赛记
                            <div class="fbli">
                				<div class="fblil"><label>选择赛事：</label></div>
                                <div class="fblir">
                                   <asp:DropDownList ID="DDLRace" Enabled ="false" runat="server" AutoPostBack="true" style="width: 200px;"></asp:DropDownList></div>
                			</div>
                			<div class="fbli">
                				<div class="fblil"><label>博客id：</label></div>
                                <div class="fblir"><input  id="txt_book" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 200px;"></div>
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