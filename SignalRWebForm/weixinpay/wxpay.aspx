<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wxpay.aspx.cs" Inherits="weixinpay_wxpay" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>团购-益跑网个人中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="/Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/Group.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/groupmedia.css" />
    <script type="text/javascript" src="../Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/modernizr.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap-validation.min.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="../Common/jCity.js"></script>
    <script src="../Common/jCheck.js"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <style>
        .main-left ul .user-dq {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }
    </style>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<body>
    <form id="form1" runat="server">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="wrap">
        <article>
        	       <div class="racepay">
            <h3>您选订的产品：</h3>
            <h4><asp:Literal ID="ltlTitle" runat="server"></asp:Literal></h4><br>
            请您及时付款，以便订单尽快处理！ 订单号：<asp:Literal ID="ltlidOrder" runat="server"></asp:Literal> <br>
			请您在提交订单后<em><b><asp:Literal ID="ltltime" runat="server"></asp:Literal>分钟</b></em>内完成支付，否则订单会自动取消。 <br>
            应付金额 ：￥<i><asp:Literal ID="ltlPrice" runat="server"></asp:Literal></i><div class="zfzt"></div>

       </div> 
       <style type="text/css">
       .racepay{width: 770px;padding: 0 34px;  margin: 0 auto;color: #7f8c8d;font-size: 14px;line-height: 21px;}
       .racepay h3 {color: #f39d00;font-size: 30px;font-weight: 100;line-height: 38px;margin-bottom: 0;}
       .racepay h4 {    color: #666666;    font-size: 16px;    font-weight: 100;    margin: 14px 0 0 0}
        .racepay em {color:red; }
       	.rcode{width: 300px;height: 296px;border: 1px solid #dddddd;border-bottom: 60px solid #f5b133;text-align: center;padding-top: 6px;}
       	.rcode img{width:288px;}
        .weixin{background: url(/Html/images/wxsm.png) no-repeat 400px top;border-top: 1px dashed #d9e5df;width: 770px;margin: 16px auto;padding: 36px 34px}
         .zfzt { color:red;}
         .racepay i {    color: #f34500;   font-size: 18px;font-style: normal;}
         .wxtopbg{width: 100%;height: 100%;position: fixed;background: rgba(75,61,58,.5);z-index: 999;top: 0;left: 0;display: none;}
         .wxtopbox{position: fixed;width: 408px;height: 190px;background: #fefefe;top: 50%;left: 50%;z-index: 1000;margin-left: -204px;margin-top: -95px;border: 1px solid #dbdbdb;text-align: center;display: none;}
         .paymsg{font-size: 30px;padding-top: 60px;line-height: 1;padding-bottom: 28px;}
         .wxpsuccess{color: #ff8604;font-style: normal;}
         .wxperror{color: #b46d11;font-style: normal;}
         .paymsg img{display: inline-block;margin-right: 14px;}
         .wxtopbox a{padding: 0 12px;color: #327fbc;line-height: 1;text-decoration: underline;}
         .wxtopbox em{position: absolute;right: 8px;top: 8px;width: 16px;height: 16px;border-radius: 50%;background: #c1c1c1;color: #fff;text-align: center;line-height: 14px;font-family: Arial;cursor: pointer;}
       </style>
       <div class="weixin"> 
       		<div class="rcode">
                 <img src="/Competetion/payment/QRcode.aspx?parm=<%= parm %>" id="vimg" alt="" />
                  <%--  <img src="/Competetion/payment/QRcode.aspx?parm=weixin://wxpay/bizpayurl?pr=z0d9Ace" id="vimg" alt="" />--%>
            
       		</div>
       </div>
        </article> 
    </div>
    <div class="wxtopbg"></div>
    <div class="wxtopbox">
      <em>x</em>
        <div class="paymsg"></div>
        <a href="/infocenter/Rlist.aspx?uId=100000605">查看订单</a><a href="/GroupBuy/GroupList.aspx">继续购物</a>
    </div>
   <script type="text/javascript">
       var int=self.setInterval("gettwo()",3000)
       jQuery(document).ready(function ($) {        
           timedCount()
       });
       var t;
       function timedCount() {
           t = self.setInterval("gettwo()", 2000);
       }
       function stopCount() {
           clearTimeout(t);
       }
   
       function gettwo() {
           $.ajax({
               type: "GET",
               url: "/action/AjaxTour.ashx",
               data: { m: "wxpay",  id: "<%=id%>", idOrder: "<%=idorder%>", idGood: "<%=idGood%>", rnd: Math.random() },              
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //console.log(data.status)
                    if (data.status == "-1") {
                        $(".zfzt").html(data.msg);
                        stopCount();
                    } else if (data.status == "0") {
                        stopCount();
                        PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                    } else if (data.status == "1") {
                        $(".zfzt").html(data.msg);
                        $(".zfzt").attr("color", "green");
                        $(".paymsg").html('<img src="/Html/images/wxpaysuccess.png"><i class="wxpsuccess">您已支付成功！</i>')
                        $(".wxtopbox,.wxtopbg").show()
                    } else {
                        $(".zfzt").attr("color", "green");
                        $(".paymsg").html('<img src="/Html/images/wxpayerror.png"><i class="wxpsuccess">支付失败！</i>')
                    }
                }
            });
     }
     $(".wxtopbox em,.wxtopbg").click(function(event) {
       $(".wxtopbox,.wxtopbg").hide()
     });
    </script>
         </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>