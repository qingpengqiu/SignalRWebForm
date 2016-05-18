<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanIndex.aspx.cs" Inherits="TrainingPlan_PlanIndex" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title>ѵ���ƻ�-�ܲ�װ��-������-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <meta property="wb:webmaster" content="a859eadcc5aee52a" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/plan.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script src="/Html/js/jquery-1.11.1.min.js"></script>
    <script src="/Html/js/marathon.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="../Common/jCalendar.js"></script>
</head>
<body>
	<style type="text/css">
		.planbox{display: none;}
    .planbox label{display: block;padding-left: 124px;font-size: 20px;color: #fff;text-shadow: 1.5px 2.598px 5px rgba( 0, 0, 0 ,0.4);cursor: pointer;height: 58px;line-height: 58px;}
    .planbox label input{width: 78px;height: 38px;line-height: 38px;border-radius: 5px;border: 0;padding-left: 8px;font-size: 20px;}
    .planbox label .birthday{background: url(/Html/images/bricon.png)  no-repeat #fff 138px center;width: 160px; }
.planinputbox{position: absolute;width: 278px;height: 240px;z-index: 9999;background: rgba(48,45,23,.95);display: none;border-radius: 3px;box-shadow: 0 3px 0px rgba(0,0,0,.18);font-size: 12px;color: #fff;}
.planinputbox input[type=text]{width: 36px;height: 24px;line-height: 24px;border: 1px solid #282314;border-radius: 1px;color: #43453e;text-align: center;}
.planinputbox i{display: inline-block;width: 78px;text-align: right;font-style: normal;padding-right: 6px}
.planinputbox p{padding-bottom: 18px;}
.planpl{padding: 20px 0 20px 30px}
.planpl input{margin-top: -1px;}
.planbuttommini{width: 61px;height: 26px;line-height: 26px;color: #fff;text-align: center;background: url(/Html/images/planbuttommini.png);display: block;margin: 0px 0 0 84px;}
.planbuttommini:hover{color: #fff;text-decoration: none;cursor: pointer;}
.planwbox{width: 200px;text-align: center;height: 114px;line-height: 25px;padding-top: 30px;}
.planwbox .planbuttommini{margin: 15px auto}
.planinputbox em{width: 0;display: inline-block;height: 0;border-left: 6px solid transparent;border-right: 6px solid transparent;border-bottom: 10px solid rgba(48,45,23,.95);position: absolute;top: -10px;left: 48px;}
.plantbg{width: 100%;height: 100%;position: fixed;display: none;top: 0;left: 0}
	</style>
<form id="form1" runat="server"> 
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="planindex">
    	<div class="articleh">
    		<div class="planindexbanner"><img src="/Html/images/plantop.jpg" ><h1>ѵ���ƻ�</h1></div>
    		<div class="planinr">
 				<div class="planimtitle">ʲô��ѵ���ƻ���</div>
 				<p>���񡤿µ�˹(Doug Kurtis)��һ��������Ъ�����������ǵ����Һͱ���ָ�����ڹ�ȥ��40��䣬������205����������������3Сʱ�ڵĳɼ����������200�������ĵ�200��3Сʱ����ɵ������ɣ�����ȥ��8�µĵ������������������������ⳡ�����ÿµ�˹��Ϊ�ڲ�ͬ��5��ʮ���ڶ������������µ�33����֮һ��
ͨ��������ѵ����ʽ���µ�˹�ɹ������˹��ȵ��������ĺ��˲��������ʱ�������������ܣ���ѡ��ͬ��·�ߺ�ѵ����飬ÿ��һ��ʱ�䵱�����Լ���Ҫ��Ϣ���ͻ���Լ��ż���١�</p>
				<img src="/Html/images/planlz.jpg" />
                <asp:Literal ID="litCreatePlan" runat="server"></asp:Literal>
 				<div class="planimtitle">�ҵĵ�ǰѵ���ƻ�</div>
<%-- 				<div class="thisplan">
 					<h2>��һ . 5�����Ъ��</h2>
					<i>10min LL</i>
					<i>10X400m ��Ϣ: 200m</i>
					<i>10min LL</i>
					<i>10min LL</i>
					<i>10X400m ��Ϣ: 200m</i>
					<i>10min LL</i>
					<div class="planiaction">
						<em class="plany">�����</em>
						<em class="planw">δ���</em>
						<em class="planb">�����</em>
					</div>
					<a href="">�鿴����ѵ���ƻ�</a>
 				</div>	--%>
                <asp:Literal ID="litCurrentDayPlaninfo" runat="server"></asp:Literal>
 				<div class="planimtitle">�ҵ���ʷѵ���ƻ�</div>
 				<div class="oldiplan">
 					<%--<a href="">��һ�ܣ�10�����Ъ��</a><a href="">��һ�ܣ�10�����Ъ��</a><a href="">��һ�ܣ�10�����Ъ��</a><a href="">��һ�ܣ�10�����Ъ��</a><a href="">��һ�ܣ�10�����Ъ��</a>--%>
                     <asp:Literal ID="litHistoryPlans" runat="server"></asp:Literal>
                 </div>
    		</div>
		</div>
    </div>
    <div id="planybox" class="planinputbox"><em></em>
    	<div class="planpl">
            <label><input type="radio" name="fatigue" value="0">��ƣ��</label>
			<label><input type="radio" name="fatigue" value="1">���ƣ��</label>
			<label><input type="radio" name="fatigue" value="2">��ƣ��</label>
    	</div>
        <p><label><i>ʱ��:</i><input type="text" name="time" value=""> ����</label> </p>
        <p><label><i>ƽ������:</i><input type="text" name="avgheartrate" value=""> ��/����</label> </p>
        <p><label><i>����:</i><input type="text" name="km" value=""> ����</label> </p>
        <a class="planbuttommini">�� ��</a>
    </div>
    <div id="planwbox" class="planinputbox planwbox"><em></em>
    	��û����ɽ���ļƻ� <br>
        <a class="planbuttommini">�� ��</a>
    </div>
    <input id="ResultState" type="hidden" value="" />
    <input id="currentday" type="hidden" value="<%=currentDay %>" />
    <input id="Plan_PersonId" type="hidden" value="<%=Plan_Person_Id %>" />
    <input id="CurrenWeek" type="hidden" value="<%=currentweek %>"/>
    <input id="currmondayofdate" type="hidden" value="<%=currmondayofdate %>" />
    <div class="plantbg"></div>
</form>
    <script type="text/javascript">
        $(".plany").click(function(event) {
        	$(".plantbg").show()
        	$(".planinputbox").hide()
        	$("#planybox").css({
	        		top: $(this).offset().top+41,
	        		left: $(this).offset().left
        	}).show()
        	if ($(this).text() == "�����")
        	    $("#ResultState").val("1");
        });
        $(".planw").click(function(event) {
        	$(".plantbg").show()
        	$(".planinputbox").hide()
        	$("#planwbox").css({
	        		top: $(this).offset().top+41,
	        		left: $(this).offset().left
        	}).show()
        	$("#ResultState").val("0");
        });
        $(".plantbg").click(function(event) {
        	$(".planinputbox").hide()
        	$(this).hide()
        });
        $(".planbuttommini").click(function (event) {
            var planpersonid = $("#Plan_PersonId").val();
            var currentweek = $("#CurrenWeek").val();
            var currmondayofdate = $("#currmondayofdate").val();
            var resultstate = $("#ResultState").val();
            var currentday = $("#currentday").val();
            var fatigue = $("input[name='fatigue']:checked").val();
            var time = $("input[name='time']").val();
            var avgheartrate = $("input[name='avgheartrate']").val();
            var km = $("input[name='km']").val();
            var postdata = { planpersonid: planpersonid, currmondayofdate: currmondayofdate, currentweek: currentweek, currentday: currentday, resultstate: resultstate, fatigue: fatigue, time: time, avgheartrate: avgheartrate, km: km ,type:"index"};
            $.post("/TrainingPlan/action/Feedback.ashx", postdata, function (result) {
                var jsonobj = JSON.parse(result);
                if (jsonobj[0] == -4)
                {
                    alert("������Ϣ�ύδ�ɹ����������ύ��");
                }
                else if (jsonobj[0] == 1)
                {
                    alert("������Ϣ�ύ�ɹ����������ͣ�");
                    $("#plancontentofday").html(jsonobj[1]);
                    $("#plancontentofday").append("<div class='planiaction'></div>");
                    $(".plantbg").hide();
                    $(".planinputbox").hide();

                    $("#ResultState").val("");
                    $("#currentday").val("");
                    $("input[name='fatigue']").attr("checked", false);
                    $("input[name='time']").val("");
                    $("input[name='avgheartrate']").val("");
                    $("input[name='km']").val("");
                }
                else if (jsonobj[0] == 0)
                {
                    alert("���ȵ�¼��");
                    PopupShowdl(520, 305, '��¼', '/utility/include/login.aspx');
                    StatusCheck();
                }
                else if (jsonobj[0] == -1) {
                    alert("���ܼƻ���ʼʱ����" + currmondayofdate+"�����ʱ����дѵ��������Ϣ��")
                }
                else if (jsonobj[0] == -3) {
                    alert("����д�����ݲ��淶������ϸ�������ύ���ݣ�")
                }
            });
        })
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />

</body>
</html>

