<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TrainingPlan.aspx.cs" Inherits="TrainingPlan_TrainingPlan" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
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
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Html/css/plan.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<style type="text/css">
body{position: relative;}
.plan{background-image: url(/Html/images/planbgn.jpg);padding:48px 0;}
.plannew{width: 930px;border: 1px solid rgba(255,255,255,.6);margin: 0px auto;background: rgba(55,54,40,.8);font-size: 12px;line-height: 24px;color: #fff;text-align: center;}
.plantr{overflow: hidden;display: table-row;}
.plantd{display: table-cell;background: rgba(245,243,243,.15);border-right: 1px solid rgba(255,255,255,.3);border-bottom: 1px solid rgba(255,255,255,.3);padding: 28px 15px;min-height:72px;vertical-align: middle;}
.plantr:first-child .plantd{height: 37px;line-height: 37px;background: none;font-size: 14px;color: #fff;padding: 0}
.plantr:last-child .plantd{border-bottom: 0}
.plantr .plantd:first-child{width: 92px;background: none;padding: 0}
.plantr .plantd:last-child{border-right: 0;width: 450px;}
.plantr .plantd:nth-child(2){width: 386px;}
.planbuttom{display: inline-block;width: 108px;height: 31px;background: url(/Html/images/planbuttom.png) center top;line-height: 31px;margin: 0 6px}
.planbuttom:hover{background-position: center bottom;cursor: pointer;}
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
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server"> 
    <div class="plan ">
        <input type="hidden" id="Plan_PersonId"  value="<%=Plan_Person_Id %>" />
        <input type="hidden" id="CurrenWeek" value="<%=currentweek %>" />
        <input type="hidden" id="currmondayofdate" value="<%=currmondayofdate %>" />
        <div class="plannew">
        	<div class="plantr">
        		<div class="plantd">��<%=strcurrentweek %>��</div>
        		<div class="plantd">ѵ������</div>
        		<div class="plantd">ѵ������</div>
        	</div>
            <asp:Literal ID="litWeekPlan" runat="server"></asp:Literal>
<%--        	<div class="plantr">
        		<div class="plantd">��һ</div>
        		<div class="plantd">
        			10min LL <br>
					10X400m ��Ϣ: 200m <br>
					10min LL</div>
        		<div class="plantd"><input type="hidden" class="weekday" value="1" /><div class="planbuttom plany">�����</div><div class="planbuttom planw">δ���</div><div class="planbuttom planb">�����</div></div>
        	</div>
        	<div class="plantr">
        		<div class="plantd">�ܶ�</div>
        		<div class="plantd">
        ��Ϣ
        			</div>
        		<div class="plantd"></div>
        	</div>
        	<div class="plantr">
        		<div class="plantd">����</div>
        		<div class="plantd">
        ����2���ӽ�����2���ӣ�����2���ӽ�����1���ӣ�����2���ӽ�����1���ӣ�����2���ӽ�����1���ӣ�����2���ӽ�����1���ӣ�����2���ӽ�����1���ӣ�����2���ӽ�����1���ӣ�����2���ӽ�����1���ӣ���25���� GR
        		</div>
        		<div class="plantd"><input type="hidden" class="weekday" value="3" /><div class="planbuttom plany">�����</div><div class="planbuttom planw">δ���</div><div class="planbuttom planb">�����</div></div>
        	</div>
        	<div class="plantr">
        		<div class="plantd">����</div>
        		<div class="plantd">
        			10min LL <br>
					10X400m ��Ϣ: 200m <br>
					10min LL</div>
        		<div class="plantd">����� | ״̬����ƣ�� | ʱ�䣺90 ���� | ƽ�����ʣ�120 ��/���� | ���룺12 ����</div>
        	</div>
            <div class="plantr">
                <div class="plantd">����</div>
                <div class="plantd">
                    10min LL <br>
                    10X400m ��Ϣ: 200m <br>
                    10min LL</div>
                <div class="plantd">����� | ״̬����ƣ�� | ʱ�䣺90 ���� | ƽ�����ʣ�120 ��/���� | ���룺12 ����</div>
            </div>
            <div class="plantr">
                <div class="plantd">����</div>
                <div class="plantd">
                    10min LL <br>
                    10X400m ��Ϣ: 200m <br>
                    10min LL</div>
                <div class="plantd">����� | ״̬����ƣ�� | ʱ�䣺90 ���� | ƽ�����ʣ�120 ��/���� | ���룺12 ����</div>
            </div>
            <div class="plantr">
                <div class="plantd">����</div>
                <div class="plantd">
                    10min LL <br>
                    10X400m ��Ϣ: 200m <br>
                    10min LL</div>
                <div class="plantd">����� | ״̬����ƣ�� | ʱ�䣺90 ���� | ƽ�����ʣ�120 ��/���� | ���룺12 ����</div>
            </div>--%>
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
    <input id="currentday" type="hidden" value="" />
    <div class="plantbg"></div>
    <script type="text/javascript">
        $(".plany,.planb").click(function(event) {
        	$(".plantbg").show()
        	$(".planinputbox").hide()
        	$("#planybox").css({
	        		top: $(this).offset().top+41,
	        		left: $(this).offset().left
        	}).show()
        	if ($(this).text() == "�����")
        	    $("#ResultState").val("1");
        	else if ($(this).text() == "�����")
        	    $("#ResultState").val("2");
        	$("#currentday").val($(this).parent().find(".weekday").val());
        });
        $(".planw").click(function(event) {
        	$(".plantbg").show()
        	$(".planinputbox").hide()
        	$("#planwbox").css({
	        		top: $(this).offset().top+41,
	        		left: $(this).offset().left
        	}).show()
        	$("#ResultState").val("0");
        	$("#currentday").val($(this).parent().find(".weekday").val());
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
            var postdata = { planpersonid: planpersonid, currmondayofdate: currmondayofdate, currentweek: currentweek, currentday: currentday, resultstate: resultstate, fatigue: fatigue, time: time, avgheartrate: avgheartrate, km: km };
            $.post("/TrainingPlan/action/Feedback.ashx", postdata, function (result) {
                var jsonobj = JSON.parse(result);
                if (jsonobj[0] == -4)
                {
                    alert("������Ϣ�ύδ�ɹ����������ύ��");
                }
                else if (jsonobj[0] == 1)
                {
                    alert("������Ϣ�ύ�ɹ����������ͣ�");
                    $(".plantr:eq(" + currentday + ")").find(".plantd:eq(2)").text(jsonobj[1]);
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
                else if (jsonobj[0] == -2) {
                    alert("��һ���ѵ���ƻ���δ��ʼ����" + jsonobj[1] + "����дѵ��������Ϣ��")
                }
                else if (jsonobj[0] == -3) {
                    alert("����д�����ݲ��淶������ϸ�������ύ���ݣ�")
                }
                else if (jsonobj[0] == 2) {
                    alert("���ܲ�����ɣ���������������ƣ��״̬��ϵͳΪ�������˸��ʺϵ�ѵ���ƻ����������ͣ�");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
                else if (jsonobj[0] == 3) {
                    alert("���ܲ�����ɣ���������������ƣ��״̬�����ܽ�ִ����һ�ܵ�ѵ���ƻ����ݣ��������ͣ�");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
                else if (jsonobj[0] == 4) {
                    alert("���ܲ�����ɣ������������ܶ�û�����ѵ���ƻ���ѵ���ƻ������¿�ʼ���������ͣ�");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
                else if (jsonobj[0] == 9) {
                    alert("���ܲ�����ɣ���ϲ������˸���ѵ���ƻ���");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
                else if (jsonobj[0] == 10) {
                    alert("����ѵ���ƻ���ȫ����ɣ��������ͣ�");
                    window.location.href = "/TrainingPlan/PlanIndex.aspx";
                }
            });
        })
    </script>
    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>