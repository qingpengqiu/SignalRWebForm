<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Integral.aspx.cs" Inherits="infocenter_Integral" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<form id="form1" runat="server">
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="main-right integralone">
        <div class="equip">
            <span data-do="integralexchange">积分兑换</span>
            <span data-do="integrallist">积分清单</span>
            <a href="/blog/200016255.aspx" class="howin" target="_blank">(如何获得积分？)</a><a class="alljf">总积分：<i><%=num %></i>分</a>
        </div>
        <div class="blog convert integralexchange">
            <ul class="items">
                <asp:Repeater ID="rptTour" runat="server">
                    <ItemTemplate>
                        <li data-wareid="<%#Eval("id").ToString()%>" data-mprice="<%#Eval("fMarketPrice").ToString()%>">
                            <img src="<%#Eval("cImage").ToString()%>" alt=""><em><%#Eval("cName").ToString()%></em>
                            <%#Eval("fSellPrice").ToString()=="0.00"?" <i>"+Eval("iScore").ToString()+"</i>积分":" <i>"+Eval("iScore").ToString()+"</i>积分+<span>"+Eval("fSellPrice").ToString()+"</span>元" %>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>   
                        <asp:Label ID="lblEmpty" Text="兑换物品正在上架中，敬请期待……" runat="server"  Visible='<%#bool.Parse((rptTour.Items.Count==0).ToString())%>' CssClass="lbEmpty"></asp:Label>
                    </FooterTemplate>  
                </asp:Repeater> 
            </ul>
            <webdiyer:AspNetPager ID="APager" runat="server" FirstPageText="<<" LastPageText=">>"
                NextPageText="下一页" CssClass="pages"
                CurrentPageButtonClass="cpb" PrevPageText="上一页"
                OnPageChanged="APager_PageChanged" PageSize="20">
            </webdiyer:AspNetPager>                            
        </div>
        <div class="blog integrallist">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <%=IntegralList %>
                    <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                        NextPageText="下一页" CssClass="pages"
                        CurrentPageButtonClass="cpb" PrevPageText="上一页"
                        OnPageChanged="pager_PageChanged" PageSize="20">
                    </webdiyer:AspNetPager>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</article>
<div class="defaultbg" id="defaultbg"></div>
<div id="itemsbuy" class="defaultbox integralbox">
    <div class="dboxtitle">商品介绍 <i></i></div>
    <div class="itembox">
    </div>
</div>
<script type="text/javascript">
var jfnum = <%=num %>,
    loca = GetQueryString("tablep")
if ((loca != 'integralexchange') && (loca != 'integrallist')) {
    loca = 'integralexchange'
};
$(".equip span").click(function () {
    loca = $(this).data('do')
    $(".equip span[data-do="+loca+"]").addClass('equip-ous').siblings('span').removeClass('equip-ous')
    $(".blog").hide()
    $('.'+loca).show()
})
jQuery(document).ready(function ($) {
$('.'+loca).show()
$(".equip span[data-do="+loca+"]").addClass('equip-ous').siblings('span').removeClass('equip-ous')
});
$(".article-up-iframe").colorbox({ iframe: true, width: "654px", height: "430px", opacity: "0.4"});
$(".items li").click(function(event) {
    var imgsrc = $(this).find('img').attr('src'),
        title = $(this).find('em').html(),
        Integral = $(this).find('i').html(),
        rmb = $(this).find('span').html()?'+'+$(this).find('span').html()+'元':'',
        mprice = $(this).data('mprice'),
        wareid = $(this).data('wareid'),
        goitem
    if(jfnum> Integral){
        goitem = '<br><a class="goitem" href="/GroupBuy/ICart.aspx?id='+wareid+'">立即兑换</a>'
    }else{
        goitem = '<br>当前积分不足,<a target="_blank" href="/blog/200016255.aspx">点击查看积分来源</a>'
    }
    $('#itemsbuy .itembox').html('<img src="'+imgsrc+'"><h2>'+title+'</h2>市 场 价：<i>'+mprice+'</i><br/>兑换积分：<i>'+Integral+'</i> 积分'+rmb+goitem)
    $("#itemsbuy,#defaultbg").show()
});
$("#itemsbuy i,#defaultbg").click(function(event) {
    $("#itemsbuy,#defaultbg").hide()
});
</script>
</form>
<ERUN360:footerv3 runat="server" ID="footerv3" />