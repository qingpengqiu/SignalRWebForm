<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Shoe.aspx.cs" Inherits="infocenter_Shoe" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title><%=ctitle%>-�ܲ�װ��-������-ERUN360.COM</title>
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
    <link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<style>
.nav li.h_zb em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
</style>
<body>
     <form id="form1" runat="server">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
		<div class="shoel">
			<div class="shoelt">
				<img src="/Html/images/shoe.png" alt="" />
				<span>�ܲ�Ь</span>
                <a href="/infocenter/ShoeFind.aspx">������Ь</a>
                <a href="/SmartChooseShoe/ShoesMine.aspx">ͬ������</a>
				<a href="/SmartChooseShoe/ShoeCounselor.aspx">����ѡЬ</a>
        <!-- <a href=""class="shoed" >ͬ������</a>
        <a href="">�߼�����</a> -->
			</div>
			<div class="shoen">
				<h1></h1>
				<div class="shoex">
					<img src="/Html/images/shoe1.jpg" alt="" />
					<ul></ul>
				</div>
				<div class="shoem">
					<div class="shoei">
						<h2>��Ʒ���ܣ�</h2>
					</div>
					<div class="shoez">
						<span>�ܽ᣺</span>
					</div>
					
					<div class="shoev" id="youkuplayer" style="display: none;">
						
					</div>
					<div class="shoeda">
						<h2>���ݷ�����</h2>
						<div id="container"></div>
					</div>
					<div class="shoeda shoec">
						<h2>����Ա���ۣ�</h2>
					</div>
					<!-- <div class="shoeda">
						<h2>����������</h2>
						<ul>
							<li>�������2.2 <span><em data-b="40"></em></span></li>
							<li>����ԣ�88.3 <span><em data-b="60"></em></span></li>
							<li>��    ����2.2 <span><em data-b="70"></em></span></li>
							<li>����ԣ�88.3 <span><em data-b="50"></em></span></li>
							<li>��    ����2.2 <span><em data-b="55"></em></span></li>
							<li>����ԣ�88.3 <span><em data-b="90"></em></span></li>
						</ul>
					</div> -->
					<div class="shoep">
						<h2>��Ҫ���ۣ�</h2>
						<asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
						<div class="blog-content">

                        <div class="discuss-border">
                            <div class="discuss-text">
                                <ERUN360:Phiz runat="server" ID="Phiz" />
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <textarea style="font-size: 14px; padding: 5px;" rows="3" cols="70" name="cContent" id="cContent" runat="server"></textarea><br>
                                        <asp:Label ID="lbtip" runat="server" ForeColor="Red"></asp:Label>
                                        <%if (cId == 0) %>
                                        <%{ %>
                                        <div class="discuss-login">
                                            <a href="/Member/">ע��</a>|
                                            <a onclick="PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();" href="javascript:">��¼</a>

                                        </div>
                                        <%} %>
                                        <%else %>
                                        <%{ %>
                                        <asp:Button ID="btnDiscuss" class="submit" runat="server" Text="�ύ" OnClick="btnDiscuss_Click" />
                                        <%} %>
                            
                                    <%=DiscussList %>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
					</div>
				</div>
			</div>
		</div>
        <div class="shoer">
          <a target="_blank" href="/zt/runbook/index.aspx"><img width="300" height="300" border="0" alt="��������ȫ��" title="��������ȫ��" src="http://www.erun360.com/adm/ad300.jpg"></a>
                <a target="_blank" href="/blog/200014474.aspx"><img width="300" height="300" border="0" alt="2014��The North Face 100��������ԽҰ��ս��������ͽ�����" title="��������ȫ��" src="/Html/images/shoetnf.png"></a>
        </div>
    </div>

<script>
   
var id = <%=bId%>,
    data = <%=Result%>,
    shoedata = 0,
    idGender = ["��", "Ů", "����"],
    cha = data.fHeel-data.fForefeet,
    idGender = data.idGender?"<li>�Ա�"+idGender[data.idGender]+"</li>":"",
    cType    = "<li>���ͣ�"+data.cType+"</li>",
    cBrand   = "<li>Ʒ�ƣ�"+data.cBrand+"</li>",
    cSeries  = data.cSeries?"<li>ϵ�У�"+data.cSeries+"</li>":"",
    fPrice   = data.fPrice!=0?"<li>�۸�&#65509;"+data.fPrice+"</li>":"",
    fWeight  = "<li>������"+data.fWeight+"g</li>",
    fForefeet= "<li>ǰ�Ÿߣ�"+data.fForefeet+"mm</li>",
    fHeel    = "<li>����ߣ�"+data.fHeel+"mm</li>",
    cfeature = data.cfeature?"<li>�ص㣺"+data.cfeature+"</li>":"",
    toFixed  = "<li>ǰ��Ÿ߲"+cha.toFixed(1)+"mm</li>",
    dTimetm  = data.dTimetm?"<li>����ʱ�䣺"+data.dTimetm+"</li>":""

                $(".shoen h1").html(data.cName)
                $(".shoex ul").html(idGender+cType+cBrand+cSeries+fPrice+fWeight+fForefeet+fHeel+cfeature+toFixed+dTimetm)
                data.cImage?$(".shoex img").attr('src', data.cImage):""
                data.cReview?$(".shoei").append(data.cReview):$(".shoei").hide()
                data.cSum?$(".shoez").append(data.cSum):$(".shoez").hide()
                data.cTester?$(".shoec").append(data.cTester):$(".shoec").hide()
                vid = data.cVideo?data.cVideo:''
                rWeight     = data.rWeight
                rHeight     = data.rHeight
                rHeel       = data.rHeel
                rForefeet   = data.rForefeet
                rStiffness  = data.rStiffness
                rStability  = data.rStability
function EmotionAdd(v) {
                document.getElementById("cContent").value += "[" + v + "]";
            }
function huifuta(bid,uid,id){
                $("#text .huifuk").remove();
                $.get("/action/GetMessageList.ashx",{ command: "state"}, function (data) {
                    console.log(data)
                   if(data == "-1"){
                    PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
                   }else {
                    $("#li"+id).append("<div class=\"huifuk\"><em></em>�ظ���<br><textarea id=\"reply\"></textarea><a class=\"reply\" onclick=\"replyd("+bid+","+uid+")\" href=\"javascript:void(0)\">����</a><a class=\"qreply\" onclick=\"qreply()\" href=\"javascript:void(0)\">ȡ��</a></div>")
                   }
                });
            }
function replyd(bid,uid){
                msg = encodeURIComponent($("#reply").val());
                

                $.get("/action/GetMessageList.ashx", { command: "AddHuiFuByShoe", id:bid,idUser: uid,op: "1",msg: msg}, function (data) {
                   if(data == "-1"){
                    PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
                   }else if(data == "1"){
                       //location.replace(location+ "#text")
                       var replaceRegex = /\#text/g;
                       date = window.location.href.replace(replaceRegex, '')
                       location = date + "#text";
                       window.location.reload()
                    $("#reply").val("");
                    $(".huifuk").remove()
                   }else if(data == "0"){
                   }
                    
                });
            }
            function qreply(){
                $(".huifuk").remove()
            }        		            
$(".shoeda em").each(function() {
	$(this).animate({left:$(this).data("b")+'%'},2100);
});

</script>
<script type="text/javascript" src="/Html/Flotr2/lib/yepnope.js"></script>
<script type="text/javascript" src="/Html/Flotr2/lib/includes.dev.js"></script>
<script type="text/javascript" src="http://player.youku.com/jsapi">
jQuery(document).ready(function($) {
	if(vid){
$("#youkuplayer").show()
    player = new YKU.Player('youkuplayer',{
    client_id: 'bf9a4d4a668be0b8',
    vid: vid
});
}
});
</script> 
          
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
         </form>
</body>
</html>