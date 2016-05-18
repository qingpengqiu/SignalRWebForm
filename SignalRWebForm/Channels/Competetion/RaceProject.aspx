<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceProject.aspx.cs" Inherits="Channels_Competetion_RaceProject" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/race.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
</head>
<body>
   <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form  id="rpfrom" runat="server">
    <div class="indecen ">
        <div class="racebody">
            <a href="/Channels/Competetion/RaceProject.aspx?idcompete=<%=id %>&la=en" class="lanen">English</a>
            <h1><asp:Literal ID="ltlTitle" runat="server"></asp:Literal></h1>
            <div class="racetip">
                <asp:Literal ID="ltlHeader" runat="server"></asp:Literal>
            </div>
            <div class="mproject">
                <h5>
                    <asp:Literal ID="ltlProject" runat="server"></asp:Literal></h5>
                <ul class="mprojectlist">
                <%=item %>
                </ul>
                <h5>
                    <asp:Literal ID="ltlFxcp" runat="server"></asp:Literal></h5>
                <ul class="mprojectother">
                   <%=xz %>
                </ul>
                <div class="integral">
                  <input type="checkbox" id="UseIntegral"> <label for="UseIntegral">您有<span><%=iScore%></span>积分,可使用<span id="integral">0</span>积分 抵扣<span id="price">0</span>元</label>
                  <div class="intError">当前积分不足以抵扣，<a href="/blog/200016255.aspx" target="_blank">点击查看积分来源</a></div>
                </div>
                <a class="racepostcn" href="javascript:void(0)" >下一步</a>
                <div class="gamein"><input type="checkbox" id="agree" checked="false"/><asp:Literal ID="ltlbsxz" runat="server"></asp:Literal></div>                
            </div>
        </div>
    </div>
    <div style='display:none'>
      <style type="text/css">
        #racetip{width:92%;background:#fff;color:#000;padding:10px 4% 31px 4% }
        #racetip h2{font-size: 22px;text-align: center;}
        #racetip h3{font-size: 18px;}
        #racetip span{color: red}
      </style>
        <div id="racetip" >
          <h2>报名须知</h2>
          <h3>国内赛事</h3>

1、报名者已阅读本赛事<a href="<%=idblog%>" target="_blank">《竞赛规程》</a>和组委会发布的赛事责任声明。<br>
2、本报名系统规定了报名者须接受组委会网上报名的各项条款。为完成全部报名过程，须认真阅读、理解并同意接受竞赛规程和相关规定。<br>
3、报名者依照收费标准，在提交报名申请的同时，须在规定时间内完成网上支付流程，逾期即未报名成功。<br>
4、鉴于组委会将根据您提交的信息为您购买保险和提供相关其他服务，报名者应真实、准确填写个人信息，正确选择比赛项目，如提供不实、不详信息，后果由报名者自负。

          <h3>海外赛事</h3>
1、因个人因素如行程变更、签证等原因未能成行，益跑网不予退还费用。<br>
2、您需要提供有效护照及签证（益跑网将提供所需材料清单并协助提供签证申请辅助材料）。<br>
3、根据相关国家的法律规定，您知晓并理解参加该项赛事有潜在风险。需证实自身的身体条件适合参与该项赛事及相关活动，具备参与赛事及活动的相应技能，并从未被告知不适宜该活动。<br>
4、您理解该赛事将在对公众开放的公共道路上举办，并理解由此带来的风险。参加该项比赛包含不能被完全排除的内在风险，这些风险包括从轻微伤到重大伤害以及死亡的范围；理解参与赛事及相关活动期间会有各方不可知的风险，这些风险也不能被任何一方合理预见。同意承担所有前述风险。接受以下由于参加该赛事及活动乙方个人及乙方的财产可能面临风险的个人责任，任何伤病、疾病、伤害、损失、责任、及相关花费；同意在参与赛事前检查相关场地及设施。关于任何在参加赛事及活动时会出现的伤害、疾病、医疗状况，您授权当自己不能完全表达意思时，在场的医疗人员对您进行任何必须的紧急救治、手术。此外，您授权这些紧急治疗费用都将由您个人承担。您确认被免除责任各方没有责任和义务提供或不能提供医疗救治。<br>
5、您授权赛事相关方对您参赛进行拍摄并在供各媒体使用。<br>
6、您确认服从其他由赛事组委会官方旅行服务商制定的与赛事相关的规定、规则等。 <br><br>
 
<span>益跑网报名支付成功后，一概不退报名费（付款之后报名截止之前，填错的报名信息可通过邮件或电话联系工作人员帮您修改）。如您因各种原因不想参与比赛，请您自行负责。转让名额是组委会不允许的，如您私下转让名额，益跑网不对后果负责。</span><br>
 <br>
如有疑问请于工作时间致电：0086-010-84374449   <br>
或发送电子邮件至 <a href="mailto:info@erun360.com">info@erun360.com</a>
             <div id="bmxz" >
参赛选手声明：<br>
1、本人自愿报名参加北京国际山地徒步大会及一切相关活动(以下统称“大会<br>
2、本人全面理解并同意遵守组委会及协办机构(以下统称“组办方”)所制订的各项规程、规则、规定、要求及采取的措施；<br>
3、本人身体健康，已为参会做好充分准备，并确认自身身体和精神健康状况方面情况符合参加本次活动的各项要求；<br>
4、本人全面理解参会可能出现的风险，并对参会可能发生的各种风险和意外已作了全面、审慎地评估，且已准备必要的防范措施；本人愿意承担大会期间发生的自身意外风险责任，且同意组办方对于非组办方原因造成的伤害、死亡或其他任何形式的损失不承担任何形式的赔偿，并愿意自行承担由此产生的一切后果；<br>
5、本人同意接受组办方在活动期间提供的现场急救性质的医务治疗，但在医院救治等发生的相关费用由本人自理；<br>
6、本人授权组办方及指定媒体无偿使用本人的肖像、姓名、声音和其它个人资料用于活动的组织和推广，进行各项宣传活动；<br>
7、本人承诺以自己的名义报名并参赛，绝不将报名后获得的号码布以任何方式转让给他人；<br>
8、本人同意在活动前和活动期间不得损害、更改及遮盖大会官方号码布；<br>
9、本人同意向组办方提供有效的身份证件和资料用于核实本人的身份，并同意承担因身份证件和资料不实所产生的全部责任；<br>
10、本人同意组办方以本人为被保险人投保人身意外险，具体内容已从保险说明书中知晓，本人均予以认可；<br>
11、本人保证在活动过程中服从裁判和工作人员的管理和指挥。<br>
12、本人或法定代理人已认真阅读并全面理解以上内容，且对上述所有内容予以确认并承担相应的法律责任。<br>
                 为大象而奔走，为保护大象而承诺。
每年大约有25，000头非洲象因人类的象牙需求而惨遭盗猎，近十年来大象的数量已减少了62%。因此，我保护大象，我承诺：
1. 个人不购买和使用象牙制品，不将象牙作为礼品赠送；
2. 劝说亲朋好友不购买象牙制品。
没有买卖，就没有杀害！<br><img src ="/Html/images/tb_ysjy.png"/>
        </div>  
        </div>
    </div>
        </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script>
    $(".projecttips").click(function(event) {
      $(this).hide()
      event.preventDefault();
    });
    $(".aracetip").colorbox({ inline:true, width: 600, height: 363, opacity: "0.4" });
    $(".aracetipm").colorbox({ inline:true, width: '100%', height: 300, opacity: "0.4" });
    function integral(t){
      var integral = t.data('integral'),
                price = t.data('price'),
                dprice = t.data('dprice'),
                iScore = <%=iScore%>
                $("#integral").html(integral)
                $("#price").html(price)
                $("#lprice").html(dprice-price)
                if(iScore < integral){
                  $("#UseIntegral").attr('disabled', 'true').removeAttr('checked');
                  $(".intError").show()
                  $(".integral").show()
                }else{
                  if(integral == 0){
                    $(".integral").hide()
                    $("#UseIntegral").removeAttr('checked');
                  }else{
                    $("#UseIntegral").removeAttr('disabled')
                    $(".intError").hide()
                    $(".integral").show()
                  }
                }
    }
        $(".mprojectlist input").on('click', function (event) {
            $(".projecttips").hide()
            $(this).next("label").find(".projecttips").show();
        integral($(this))
            
        });
        jQuery(document).ready(function($) {
            $('.mprojectlist input').each(function(index, val) {
               if (val.checked) {
                integral($(this))
               };
            });
            function GetQueryString(name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                    }
            if(GetQueryString("la") == "en"){
                $(".lanen").attr('href', '/Channels/Competetion/RaceProject.aspx?idcompete=<%=id %>&la=cn').html("中文");
                $("#rpfrom").attr('action', 'RaceProject2.aspx?idcompete=<%=id %>&la=en');
            }
            $(".racepostcn").click(function(event) {
                var chk_value =[];    
                  $('input[name="projectother"]:checked').each(function(){    
                   chk_value.push($(this).val());    
                  });
                  var lang = GetQueryString("la")?GetQueryString("la"):"cn",
                  integral = $("#UseIntegral:checked").val()?1:0
                  if ($('input[name="project"]:checked').val()) {
                      if ($('input[id="agree"]:checked').val()) {
                          window.location.href = "RaceProject2.aspx?idcompete=<%=id %>&la=" + lang + "&p=" + $('input[name="project"]:checked').val() + "&o=" + chk_value + "&integral=" + integral
                    } else {
                        alert("请同意报名须知！")
                    }
                  } else {
                      alert("请选择项目！")
                  }

            });
            if(GetQueryString("idcompete") == "300000445"){
                loadjscssfile("/Html/css/racetnf.css", "css")
                $(".logo").replaceWith('<div class="tnflogo"><a href="/"><img src="/Html/images/tnflogo1.png"></a><a href="http://www.quyeba.com" target="_blank"><img src="/Html/images/tnflogo2.png"></a><a href="http://www.quyeba.com/tnf100/" target="_blank"><img src="/Html/images/tnflogo3.png"></a></div>')
            }
            
            $(".gamein a").on('click', function (event) {
                if (GetQueryString("idcompete") == "300000502") {
                    $("#bmxz").show();
                }
                else { $("#bmxz").hide(); }
            });
        });

function loadjscssfile(filename, filetype){ 
if (filetype=="js"){ //判断文件类型 
  var fileref=document.createElement('script')//创建标签 
  fileref.setAttribute("type","text/javascript")//定义属性type的值为text/javascript 
  fileref.setAttribute("src", filename)//文件的地址 
} 
else if (filetype=="css"){ //判断文件类型 
  var fileref=document.createElement("link") 
  fileref.setAttribute("rel", "stylesheet") 
  fileref.setAttribute("type", "text/css")  
  fileref.setAttribute("href", filename) 
} 
if (typeof fileref!="undefined") 
  document.getElementsByTagName("head")[0].appendChild(fileref) 
}  


    </script>
</body>
</html>
