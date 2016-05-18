<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HistoryPlanInfo.aspx.cs" Inherits="TrainingPlan_HistoryPlanInfo" %>
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
        <input type="hidden" id="Plan_PersonId"  value="" />
        <div class="plannew">
        	<div class="plantr">
        		<div class="plantd">��<asp:DropDownList ID="ddlistWeeks" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlistWeeks_SelectedIndexChanged"></asp:DropDownList>��</div>
        		<div class="plantd">ѵ������</div>
        		<div class="plantd">ѵ������</div>
        	</div>
            <asp:Literal ID="litWeekPlan" runat="server"></asp:Literal>
        </div>
    </div>
    <div class="plantbg"></div>
    <script type="text/javascript">
    </script>
    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
