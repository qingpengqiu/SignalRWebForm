<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StepFirst.aspx.cs" Inherits="TrainingPlan_StepFirst" %>

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
	</style>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="planbg plancont">
      <form id="planinput" runat="server">
		<div class="planbox" id="p1" style="display:block">
			<div class="planst">�ܲ�Ŀ��ά��ѡ���ʾ�</div>
			<h2>�ܲ�������Ŀ��</h2>
			<ul class="planlist onlist">
				<li data-b="0" data-p="1">0�������뿪ʼ�ܲ�</li>
				<li data-b="1" data-p="1">5�������������10����</li>
				<li data-b="2" data-p="1">10������������ܰ��</li>
				<li data-b="3" data-p="1">��̻���������ȫ��</li>
				<li data-b="4" data-p="1">ȫ�̻���������߳ɼ�</li>
        <input type="hidden" id="d1" name="d1">
			</ul>
		</div>
		<div class="planbox" id="p2">
			<div class="planst">�ܲ�Ŀ��ά��ѡ���ʾ�</div>
			<h2>���˷���</h2>
			<ul class="planlist onlist">
				<li data-b="101" data-p="2">��ϥ���˷��ո�</li>
				<li data-b="102" data-p="2">��ϥ���˷��յ�</li>
        <input type="hidden" id="d2" name="d2">
			</ul>
			<div class="planbu" onclick="Backoff()">�˺�һ��</div>
		</div>
		<div class="planbox" id="p3">
			<div class="planst">�ܲ�Ŀ��ά��ѡ���ʾ�</div>
			<h2>ѵ������</h2>
			<ul class="planlist onlist">
				<li data-b="10" data-p="3">10��</li>
				<li data-b="15" data-p="3">15��</li>
        <input type="hidden" id="d3" name="d3">
			</ul>
			<div class="planbu" onclick="Backoff()">�˺�һ��</div>
		</div>
    <div class="planbox" id="p4">
      <div class="planst">�ܲ�Ŀ��ά��ѡ���ʾ�</div>
      <h2>���������Ϣ</h2>
      <label>���գ�<input type="text" name="birthday" class="birthday" onclick="GDate(this);"></label>
      <label>��ߣ�<input type="text" name="height"> ����</label>
      <label>���أ�<input type="text" name="weight"> ����</label>
      <label>������<input type="text" name="pulse"> ��/����</label>
      <div class="planbu" onclick="Goplan()">��һ��</div>
    </div>
      </form>
    </div>
     
    <script type="text/javascript">
       var p = 1
       $(".onlist li").click(function(event) {
       		var b = $(this).data('b');
       			p = $(this).data('p')
            $(".planbox").hide()
            $("#p"+(p+1)).show()
            $("#d"+p).val(b)
       });
       function Backoff(){
       		$(".planbox").hide()
   			$("#p"+p).show()
   			p--
       }
       function Goplan(){
           var freqdist = $("#d1").val();
           var level = $("#d2").val();
           var period = $("#d3").val();
           var birthday = $("input[name='birthday']").val();
           var height = $("input[name='height']").val();
           var weight = $("input[name='weight']").val();
           var morningpulse = $("input[name='pulse']").val();
           if (birthday == "") {
               alert("���ղ���Ϊ�գ�");
               $("input[name='birthday']").focus();
               return;
           }
           if (height == "") {
               alert("��߲���Ϊ�գ�");
               $("input[name='height']").focus();
               return;
           }
           if (weight == "") {
               alert("���ز���Ϊ�գ�");
               $("input[name='weight']").focus();
               return;
           }
           if (morningpulse == "") {
               alert("��������Ϊ�գ�");
               $("input[name='pulse']").focus();
               return;
           }

           var postdata = { freqdist: freqdist, level: level, period: period, birthday: birthday, height: height, weight: weight, morningpulse: morningpulse };
           $.post("/TrainingPlan/action/PlanInfo.ashx", postdata, function (returnvalue) {
               switch (returnvalue) {
                   case "-1":
                       alert("�����������ĸ�����Ϣ��");
                   case "0":
                       alert("���ȵ�¼��");
                       PopupShowdl(520, 305, '��¼', '/utility/include/login.aspx');
                       StatusCheck();
                       break;
                   case "1":
                       alert("���ɸ���ѵ���ƻ��ɹ���");
                       window.location.href = "/TrainingPlan/PlanIndex.aspx";
                       break;
                   case "2":
                       alert("���ɸ���ѵ���ƻ�ʧ�ܣ������Ի�����ϵ��վ����Ա");
                       window.location.href = "/TrainingPlan/PlanIndex.aspx";
                       break;
                   default:
               }
           });

       }
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>

