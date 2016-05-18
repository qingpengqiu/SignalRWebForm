<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Shoe.aspx.cs" Inherits="infocenter_Shoe" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
<link href="/Html/css/shoemedia.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/Html/js/echarts.js" charset="UTF-8"></script>
<form id="form1" runat="server">
</form>
<article>
    <div class="V3Left">
        <div class="listtitlel">
            <img src="/Images/classify/1009.jpg">
            <h3>
                智能选鞋
            </h3>
        </div>
        <div class="shoelt">
            <a href="/SmartChooseShoe/ShoeFind.aspx" >查找跑鞋</a><a href="/SmartChooseShoe/ShoesMine.aspx">同类搜索</a><a href="/SmartChooseShoe/ShoeCounselor.aspx">智能选鞋</a>
        </div>
		<div class="shoen">
			<h1><%=mShoe.cName %></h1>
            <div class="shoeinfo">
			<div class="shoex">
				<img src="<%=mShoe.cImage %> " alt="" />
				<div class="shoeinfobox">
                    <div class="vsl">
                        品牌：<%=mShoe.cBrand %> <br>
                        重量：<%=mShoe.fWeight %>g <br>
                        后跟高：<%=mShoe.fHeel %>mm <br>
                        上市时间：<%=mShoe.dTimetm %>   
                    </div>
                    <div class="vsr">
                        类型：<%=mShoe.cType %> <br>
                        前脚高：<%=mShoe.fForefeet %>mm <br>
                        前后脚高差：<%=mShoe.fHeel-mShoe.fForefeet %>mm <br>
                        价格：￥<%=mShoe.fPrice %>
                    </div>
                </div>
			</div>
            <div id="shoechart"></div>
            </div>
                <%=pingtuan_html %>
			<div class="shoem">
                <%=shoeSummary %>
                <%=shoeTester %>
                <%=shoeReview %>
                <%=shoeVideo %>
                <%=shoeEvaluationBlog %>
<%--                <h2>编辑说：</h2>
				<div class="shoembox">
                    Nike Air Zoom Structure 19 男子跑步鞋采用 Flymesh 鞋面，结合三重密度泡棉中底，为你提供所需的各种支撑力与弹力，缔造流畅稳定的快速奔前掌 Nike Zoom Air 气垫打造轻薄回弹缓震配置，有力推动前进步伐，实现迅疾畅跑之势。Nike Air Zoom Structure 19 男子跑步鞋采用 Flymesh 鞋面，结合三重密度泡棉中底，为你提供所需的各种支撑力与弹力，缔造流畅稳定的快速奔前掌 Nike Zoom Air 气垫打造轻薄回弹缓震配置，有力推动前进步伐，实现迅疾畅跑之势。
				</div>
                <h2>测试者：</h2>
				<div class="shoembox">
                    Nike Air Zoom Structure 19 男子跑步鞋采用 Flymesh 鞋面，结合三重密度泡棉中底，为你提供所需的各种支撑力与弹力，缔造流畅稳定的快速奔前掌 Nike Zoom Air 气垫打造轻薄回弹缓震配置，有力推动前进步伐，实现迅疾畅跑之势。Nike Air Zoom Structure 19 男子跑步鞋采用 Flymesh 鞋面，结合三重密度泡棉中底，为你提供所需的各种支撑力与弹力，缔造流畅稳定的快速奔前掌 Nike Zoom Air 气垫打造轻薄回弹缓震配置，有力推动前进步伐，实现迅疾畅跑之势。
				</div>
                <h2>穿着感受：</h2>
				<div class="shoembox">
                    Nike Air Zoom Structure 19 男子跑步鞋采用 Flymesh 鞋面，结合三重密度泡棉中底，为你提供所需的各种支撑力与弹力，缔造流畅稳定的快速奔前掌 Nike Zoom Air 气垫打造轻薄回弹缓震配置，有力推动前进步伐，实现迅疾畅跑之势。Nike Air Zoom Structure 19 男子跑步鞋采用 Flymesh 鞋面，结合三重密度泡棉中底，为你提供所需的各种支撑力与弹力，缔造流畅稳定的快速奔前掌 Nike Zoom Air 气垫打造轻薄回弹缓震配置，有力推动前进步伐，实现迅疾畅跑之势。
				</div>
                <h2>评测视频：</h2>
				<div class="shoevidobox">

				</div>
                <div class="shoebetest">
                    <span>相关测评文章：</span>
                    <div class="shoebetestbox">
                        <a href=""><img src="/Html/images/shoe1.jpg"></a>
                        <a href="">【评测】Vibram FiveFingers CVT Wool & Trek Ascent Insulated </a>
                        <p>即将迈入第14个年头的厦门国际马拉松赛，明年将再次做出重大调整:赛事将回到厦门国际会展中心起跑，终取消半程和10公里，只设全程和5公里。</p>
                    </div>
                    <div class="shoebetestbox">
                        <a href=""><img src="/Html/images/shoe1.jpg"></a>
                        <a href="">【评测】Vibram FiveFingers CVT Wool & Trek Ascent Insulated </a>
                        <p>即将迈入第14个年头的厦门国际马拉松赛，明年将再次做出重大调整:赛事将回到厦门国际会展中心起跑，终取消半程和10公里，只设全程和5公里。</p>
                    </div>
                    <div class="shoebetestbox">
                        <a href=""><img src="/Html/images/shoe1.jpg"></a>
                        <a href="">【评测】Vibram FiveFingers CVT Wool & Trek Ascent Insulated </a>
                        <p>即将迈入第14个年头的厦门国际马拉松赛，明年将再次做出重大调整:赛事将回到厦门国际会展中心起跑，终取消半程和10公里，只设全程和5公里。</p>
                    </div>
                </div>--%>
			</div>
		</div>
	</div>
    <div class="V3Righr">
        <%= addgg.ADList(90000,1,0) %>
        <asp:Literal ID="ltlTour" runat="server"></asp:Literal>
        <%= addgg.ADList(90000,2,0) %>
        <%= addgg.ADList(90000,3,0) %>
        <%= addgg.ADList(90000,4,0) %>
        <%= addgg.ADList(90000,5,0) %>
        <%= addgg.ADList(90000,6,0) %>
        <%= addgg.ADList(90000,7,0) %>
    </div>
        <%= addgg.ADList(90000,8,0) %>
</article>
<script type="text/javascript">
option = {
    title : {
        subtext: '中心点为0，最大值100'
    },
    tooltip : {
        trigger: 'axis'
    },
    toolbox: {
        show : true,
        feature : {
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    polar : [
        {
            indicator : [
                {text : '重量', max  : 100},
                {text : '高度', max  : 100},
                {text : '后跟减震', max  : 100},
                {text : '前脚掌减震', max  : 100},
                {text : '硬度', max  : 100},
                {text : '稳定性', max  : 100}
            ],
            radius : 130
        }
    ],
    series : [
        {
            name: '当前选鞋数据',
            type: 'radar',
            itemStyle: {
                normal: {
                    areaStyle: {
                        type: 'default'
                    }
                }
            },
            data : [
                {
                    value : [<%=mShoe.rWeight %>, <%=mShoe.rHeight %>, <%=mShoe.rHeel %>, <%=mShoe.rForefeet %>, <%=mShoe.rStiffness %>, <%=mShoe.rStability %>],
                    name : '当前数据'
                }
            ]
        }
    ]
};
var myChart1 = echarts.init(document.getElementById('shoechart'),'macarons');
  myChart1.setOption(option);
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />