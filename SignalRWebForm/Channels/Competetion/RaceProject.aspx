<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceProject.aspx.cs" Inherits="Channels_Competetion_RaceProject" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
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
                  <input type="checkbox" id="UseIntegral"> <label for="UseIntegral">����<span><%=iScore%></span>����,��ʹ��<span id="integral">0</span>���� �ֿ�<span id="price">0</span>Ԫ</label>
                  <div class="intError">��ǰ���ֲ����Եֿۣ�<a href="/blog/200016255.aspx" target="_blank">����鿴������Դ</a></div>
                </div>
                <a class="racepostcn" href="javascript:void(0)" >��һ��</a>
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
          <h2>������֪</h2>
          <h3>��������</h3>

1�����������Ķ�������<a href="<%=idblog%>" target="_blank">��������̡�</a>����ί�ᷢ������������������<br>
2��������ϵͳ�涨�˱������������ί�����ϱ����ĸ������Ϊ���ȫ���������̣��������Ķ�����Ⲣͬ����ܾ�����̺���ع涨��<br>
3�������������շѱ�׼�����ύ���������ͬʱ�����ڹ涨ʱ�����������֧�����̣����ڼ�δ�����ɹ���<br>
4��������ί�Ὣ�������ύ����ϢΪ�������պ��ṩ����������񣬱�����Ӧ��ʵ��׼ȷ��д������Ϣ����ȷѡ�������Ŀ�����ṩ��ʵ��������Ϣ������ɱ������Ը���

          <h3>��������</h3>
1��������������г̱����ǩ֤��ԭ��δ�ܳ��У������������˻����á�<br>
2������Ҫ�ṩ��Ч���ռ�ǩ֤�����������ṩ��������嵥��Э���ṩǩ֤���븨�����ϣ���<br>
3��������ع��ҵķ��ɹ涨����֪�������μӸ���������Ǳ�ڷ��ա���֤ʵ��������������ʺϲ���������¼���ػ���߱��������¼������Ӧ���ܣ�����δ����֪�����˸û��<br>
4�����������½��ڶԹ��ڿ��ŵĹ�����·�Ͼٰ죬������ɴ˴����ķ��ա��μӸ�������������ܱ���ȫ�ų������ڷ��գ���Щ���հ�������΢�˵��ش��˺��Լ������ķ�Χ�����������¼���ػ�ڼ���и�������֪�ķ��գ���Щ����Ҳ���ܱ��κ�һ������Ԥ����ͬ��е�����ǰ�����ա������������ڲμӸ����¼���ҷ����˼��ҷ��ĲƲ��������ٷ��յĸ������Σ��κ��˲����������˺�����ʧ�����Ρ�����ػ��ѣ�ͬ���ڲ�������ǰ�����س��ؼ���ʩ�������κ��ڲμ����¼��ʱ����ֵ��˺���������ҽ��״��������Ȩ���Լ�������ȫ�����˼ʱ���ڳ���ҽ����Ա���������κα���Ľ������Ρ����������⣬����Ȩ��Щ�������Ʒ��ö����������˳е�����ȷ�ϱ�������θ���û�����κ������ṩ�����ṩҽ�ƾ��Ρ�<br>
5������Ȩ������ط����������������㲢�ڹ���ý��ʹ�á�<br>
6����ȷ�Ϸ���������������ί��ٷ����з������ƶ�����������صĹ涨������ȡ� <br><br>
 
<span>����������֧���ɹ���һ�Ų��˱����ѣ�����֮������ֹ֮ǰ�����ı�����Ϣ��ͨ���ʼ���绰��ϵ������Ա�����޸ģ������������ԭ�������������������и���ת����������ί�᲻����ģ�����˽��ת��������������Ժ������</span><br>
 <br>
�����������ڹ���ʱ���µ磺0086-010-84374449   <br>
���͵����ʼ��� <a href="mailto:info@erun360.com">info@erun360.com</a>
             <div id="bmxz" >
����ѡ��������<br>
1��������Ը�����μӱ�������ɽ��ͽ����ἰһ����ػ(����ͳ�ơ����<br>
2������ȫ����Ⲣͬ��������ί�ἰЭ�����(����ͳ�ơ���췽��)���ƶ��ĸ����̡����򡢹涨��Ҫ�󼰲�ȡ�Ĵ�ʩ��<br>
3���������彡������Ϊ�λ����ó��׼������ȷ����������;��񽡿�״������������ϲμӱ��λ�ĸ���Ҫ��<br>
4������ȫ�����λ���ܳ��ֵķ��գ����Բλ���ܷ����ĸ��ַ��պ�����������ȫ�桢����������������׼����Ҫ�ķ�����ʩ������Ը��е�����ڼ䷢������������������Σ���ͬ����췽���ڷ���췽ԭ����ɵ��˺��������������κ���ʽ����ʧ���е��κ���ʽ���⳥����Ը�����ге��ɴ˲�����һ�к����<br>
5������ͬ�������췽�ڻ�ڼ��ṩ���ֳ��������ʵ�ҽ�����ƣ�����ҽԺ���εȷ�������ط����ɱ�������<br>
6��������Ȩ��췽��ָ��ý���޳�ʹ�ñ��˵�Ф�����������������������������ڻ����֯���ƹ㣬���и����������<br>
7�����˳�ŵ���Լ������屨�����������������������õĺ��벼���κη�ʽת�ø����ˣ�<br>
8������ͬ���ڻǰ�ͻ�ڼ䲻���𺦡����ļ��ڸǴ��ٷ����벼��<br>
9������ͬ������췽�ṩ��Ч�����֤�����������ں�ʵ���˵���ݣ���ͬ��е������֤�������ϲ�ʵ��������ȫ�����Σ�<br>
10������ͬ����췽�Ա���Ϊ��������Ͷ�����������գ����������Ѵӱ���˵������֪�������˾������Ͽɣ�<br>
11�����˱�֤�ڻ�����з��Ӳ��к͹�����Ա�Ĺ����ָ�ӡ�<br>
12�����˻򷨶��������������Ķ���ȫ������������ݣ��Ҷ�����������������ȷ�ϲ��е���Ӧ�ķ������Ρ�<br>
                 Ϊ��������ߣ�Ϊ�����������ŵ��
ÿ���Լ��25��000ͷ����������������������������ԣ���ʮ��������������Ѽ�����62%����ˣ��ұ��������ҳ�ŵ��
1. ���˲������ʹ��������Ʒ������������Ϊ��Ʒ���ͣ�
2. Ȱ˵������Ѳ�����������Ʒ��
û����������û��ɱ����<br><img src ="/Html/images/tb_ysjy.png"/>
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
                $(".lanen").attr('href', '/Channels/Competetion/RaceProject.aspx?idcompete=<%=id %>&la=cn').html("����");
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
                        alert("��ͬ�ⱨ����֪��")
                    }
                  } else {
                      alert("��ѡ����Ŀ��")
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
if (filetype=="js"){ //�ж��ļ����� 
  var fileref=document.createElement('script')//������ǩ 
  fileref.setAttribute("type","text/javascript")//��������type��ֵΪtext/javascript 
  fileref.setAttribute("src", filename)//�ļ��ĵ�ַ 
} 
else if (filetype=="css"){ //�ж��ļ����� 
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
