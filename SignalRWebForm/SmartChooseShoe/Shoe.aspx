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
                ����ѡЬ
            </h3>
        </div>
        <div class="shoelt">
            <a href="/SmartChooseShoe/ShoeFind.aspx" >������Ь</a><a href="/SmartChooseShoe/ShoesMine.aspx">ͬ������</a><a href="/SmartChooseShoe/ShoeCounselor.aspx">����ѡЬ</a>
        </div>
		<div class="shoen">
			<h1><%=mShoe.cName %></h1>
            <div class="shoeinfo">
			<div class="shoex">
				<img src="<%=mShoe.cImage %> " alt="" />
				<div class="shoeinfobox">
                    <div class="vsl">
                        Ʒ�ƣ�<%=mShoe.cBrand %> <br>
                        ������<%=mShoe.fWeight %>g <br>
                        ����ߣ�<%=mShoe.fHeel %>mm <br>
                        ����ʱ�䣺<%=mShoe.dTimetm %>   
                    </div>
                    <div class="vsr">
                        ���ͣ�<%=mShoe.cType %> <br>
                        ǰ�Ÿߣ�<%=mShoe.fForefeet %>mm <br>
                        ǰ��Ÿ߲<%=mShoe.fHeel-mShoe.fForefeet %>mm <br>
                        �۸񣺣�<%=mShoe.fPrice %>
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
<%--                <h2>�༭˵��</h2>
				<div class="shoembox">
                    Nike Air Zoom Structure 19 �����ܲ�Ь���� Flymesh Ь�棬��������ܶ������еף�Ϊ���ṩ����ĸ���֧�����뵯�������������ȶ��Ŀ��ٱ�ǰ�� Nike Zoom Air ��������ᱡ�ص��������ã������ƶ�ǰ��������ʵ��Ѹ������֮�ơ�Nike Air Zoom Structure 19 �����ܲ�Ь���� Flymesh Ь�棬��������ܶ������еף�Ϊ���ṩ����ĸ���֧�����뵯�������������ȶ��Ŀ��ٱ�ǰ�� Nike Zoom Air ��������ᱡ�ص��������ã������ƶ�ǰ��������ʵ��Ѹ������֮�ơ�
				</div>
                <h2>�����ߣ�</h2>
				<div class="shoembox">
                    Nike Air Zoom Structure 19 �����ܲ�Ь���� Flymesh Ь�棬��������ܶ������еף�Ϊ���ṩ����ĸ���֧�����뵯�������������ȶ��Ŀ��ٱ�ǰ�� Nike Zoom Air ��������ᱡ�ص��������ã������ƶ�ǰ��������ʵ��Ѹ������֮�ơ�Nike Air Zoom Structure 19 �����ܲ�Ь���� Flymesh Ь�棬��������ܶ������еף�Ϊ���ṩ����ĸ���֧�����뵯�������������ȶ��Ŀ��ٱ�ǰ�� Nike Zoom Air ��������ᱡ�ص��������ã������ƶ�ǰ��������ʵ��Ѹ������֮�ơ�
				</div>
                <h2>���Ÿ��ܣ�</h2>
				<div class="shoembox">
                    Nike Air Zoom Structure 19 �����ܲ�Ь���� Flymesh Ь�棬��������ܶ������еף�Ϊ���ṩ����ĸ���֧�����뵯�������������ȶ��Ŀ��ٱ�ǰ�� Nike Zoom Air ��������ᱡ�ص��������ã������ƶ�ǰ��������ʵ��Ѹ������֮�ơ�Nike Air Zoom Structure 19 �����ܲ�Ь���� Flymesh Ь�棬��������ܶ������еף�Ϊ���ṩ����ĸ���֧�����뵯�������������ȶ��Ŀ��ٱ�ǰ�� Nike Zoom Air ��������ᱡ�ص��������ã������ƶ�ǰ��������ʵ��Ѹ������֮�ơ�
				</div>
                <h2>������Ƶ��</h2>
				<div class="shoevidobox">

				</div>
                <div class="shoebetest">
                    <span>��ز������£�</span>
                    <div class="shoebetestbox">
                        <a href=""><img src="/Html/images/shoe1.jpg"></a>
                        <a href="">�����⡿Vibram FiveFingers CVT Wool & Trek Ascent Insulated </a>
                        <p>���������14����ͷ�����Ź����������������꽫�ٴ������ش����:���½��ص����Ź��ʻ�չ�������ܣ���ȡ����̺�10���ֻ��ȫ�̺�5���</p>
                    </div>
                    <div class="shoebetestbox">
                        <a href=""><img src="/Html/images/shoe1.jpg"></a>
                        <a href="">�����⡿Vibram FiveFingers CVT Wool & Trek Ascent Insulated </a>
                        <p>���������14����ͷ�����Ź����������������꽫�ٴ������ش����:���½��ص����Ź��ʻ�չ�������ܣ���ȡ����̺�10���ֻ��ȫ�̺�5���</p>
                    </div>
                    <div class="shoebetestbox">
                        <a href=""><img src="/Html/images/shoe1.jpg"></a>
                        <a href="">�����⡿Vibram FiveFingers CVT Wool & Trek Ascent Insulated </a>
                        <p>���������14����ͷ�����Ź����������������꽫�ٴ������ش����:���½��ص����Ź��ʻ�չ�������ܣ���ȡ����̺�10���ֻ��ȫ�̺�5���</p>
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
        subtext: '���ĵ�Ϊ0�����ֵ100'
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
                {text : '����', max  : 100},
                {text : '�߶�', max  : 100},
                {text : '�������', max  : 100},
                {text : 'ǰ���Ƽ���', max  : 100},
                {text : 'Ӳ��', max  : 100},
                {text : '�ȶ���', max  : 100}
            ],
            radius : 130
        }
    ],
    series : [
        {
            name: '��ǰѡЬ����',
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
                    name : '��ǰ����'
                }
            ]
        }
    ]
};
var myChart1 = echarts.init(document.getElementById('shoechart'),'macarons');
  myChart1.setOption(option);
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />