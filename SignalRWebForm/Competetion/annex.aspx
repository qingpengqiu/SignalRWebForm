<%@ Page Language="C#" AutoEventWireup="true" CodeFile="annex.aspx.cs" Inherits="Competetion_annex" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
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
<div class="tbody">
    <div class="mine">
        <ERUN360:bmnav runat="server" ID="bmnav" />
        <div class="tbodyBox">
            <div class="event this clearfix">
                <form id="form1">
                    <div class="annext">
                        为您推荐的赛事配套产品
                    </div>
                    <ul class="annexlist">
                        <asp:Literal ID="ltlannex" runat="server"></asp:Literal>
                        <%--<li>
    			<label><input type="checkbox" name="annex" value="1" >中式自助餐</label>
				数量：<input type="number" clss="fen" value="1" min="1" max="10">份 <br>
				价格：￥<i>160</i>
    		</li>
    		<li>
    			<label><input type="checkbox" name="annex" value="1" >中式自助餐</label>
				数量：<input type="number" clss="fen" value="1" min="1" max="10">份 <br>
				价格：￥<i>160</i>
    		</li>--%>
                    </ul>

                        <a class="gobus" id="idannex">加入购物车</a>
                        <div class="tip"></div>
                        <style type="text/css">
                            .tip {
                                color: red;
                                margin-top: -53px;
                                text-align: center;
                            }
                        </style>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <ERUN360:ICart runat="server" ID="ICart" />
    <script>
        $("#idannex").click(function (event) {
            $.ajax({
                url: '/action/EventService.ashx?op=tjannex&sid=<%=sid%>',
                type: 'get',
                dataType: 'json',
                data: encodeURI($("#form1").serialize()),
                //data: { op: "OrderAdd", data:encodeURI($("#form1").serialize()), rnd: Math.random() },
                success: function (sdata) {
                    if (sdata.status == "-1") {
                        PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                        return false
                    } else if (sdata.status == "0") {
                        $(".toast").html(sdata.msg).show().addClass('toast-error')
                        errorboxhide()
                    }
                    else if (sdata.status == "1") {
                        $(".toast").html(sdata.msg).show().addClass('toast-success')
                        geticart()
                        errorboxhide()
                    }
                }
            });
        });
        $(".fen").change(function(event) {
            var v = $(this).val(),
                i = $(this).siblings("i"),
                iv = $(this).data('p')
            i.html(v*iv)
        });
    </script>
     <form id="from2" runat="server">
        </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />











