<%@ Page Language="C#" AutoEventWireup="true" CodeFile="internationalEvents.aspx.cs" Inherits="Channels_Competetion_internationalEvents" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<title>�����ɹ�������ֱͨ��-������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
<meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<meta property="wb:webmaster" content="a859eadcc5aee52a" />
<link href="favicon.ico" rel="shortcut icon" type="image/ico">
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<link href="/Common/cansai-from.css?2012111" rel="stylesheet" type="text/css"/>
<link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
<script language="javascript" src="/Common/jQuery1.8.js"></script>
<script language="javascript" src="/Common/jCity.js"></script>

</head>
<style>
.nav li.h_js em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
</style>
<body>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jPopup.js"></script>
<script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<style type="text/css">
.mlistnav .this{background: #e0af80;color: #fff;}
</style>
<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
    <div class="indecen internation">
      <img src="/Html/images/internationaltop.png">
      <div class="internationtop">
        <span>��������</span>�� <asp:Literal ID="ltlhot" runat="server"></asp:Literal>
         <%-- <a href="">�ձ�����������</a><a href="">�¼�������������</a><a href="">��ɼ�����������</a><a href="">��������������</a><a href="">���������������׶�����</a>--%>
        <div class="internationselect">
          <label>ʱ��</label>
              <select class="form-control timelist" id="fieldMonth" runat="server">
                   <option value="0">ȫ��</option>
                    <option value="1">���1����</option>
                    <option value="3">���3����</option>
                    <option value="6">���6����</option>
                    <option value="12">6��������</option>
              </select>
          <label>����</label>
              <select class="form-control citylist" id="form-field-select-1">
                <%=area%>
              </select>
        </div>
                                        
      </div>
	<div class="mlslist">
		<ul>
            <asp:Repeater ID="rptrunrecord" runat="server" OnItemDataBound="rptrunrecord_ItemDataBound">
                <ItemTemplate>
                    <li><span><a target="_blank" href="/blog/<%#Eval("idblog")%>.aspx"><%#Eval("cTitle")%></a></span>
				        <img src="<%#Eval("cURL").ToString()%> " width="148"/>
				        ����ʱ�䣺<%#Convert.ToDateTime(Eval("dRaceBegin")).ToString("yyyy-MM-dd")%> <br>
                        ������ֹʱ�䣺<%#Convert.ToDateTime(Eval("dJoinEnd")).ToString("yyyy-MM-dd")%> <br>
				        �������ã�<asp:Repeater runat="server" ID="rpquestionlist">
                            <ItemTemplate>
                                 <%#XString.ContentTrunc(Eval("text").ToString(), 100)%>                              
                            </ItemTemplate>
                        </asp:Repeater>				        
                         <%#DateTime.Compare(DateTime.Now,Convert.ToDateTime(Eval("dJoinEnd").ToString())) <= 0?"<a target='_blank' class='csbm' href='RaceProject.aspx?idcompete="+Eval("id")+"'>��������</a>":" <a class='jieshu'>��������</a>"%>
			        </li>
                </ItemTemplate>
            </asp:Repeater>
		</ul>
	</div>
   <div id="apage" runat="server" visible="false" class="pages">
   <asp:label ID="lblCurrentPage" runat="server"></asp:label>
   <asp:HyperLink id="lnkFrist" runat="server">��ҳ</asp:HyperLink>
   <asp:HyperLink id="lnkPrev" runat="server">��һҳ</asp:HyperLink>
   <asp:HyperLink id="lnkNext" runat="server">��һҳ</asp:HyperLink> 
   <asp:HyperLink id="lnkEnd" runat="server">βҳ</asp:HyperLink>
</div>

</div>

    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script type="text/javascript">
      var destiny = window.location.href
      var gid = GetQueryString('id')
      var gcityid = GetQueryString('cityid')
      
      jQuery(document).ready(function($) {
        $(".citylist option").each(function(index, el) {
           var ohtml = $(this).html()
           if(gcityid == ohtml){
              $(this).attr('selected', 'selected');
            }
           if (ohtml > 0) {
              $(this).html(china[ohtml-1][0])
           };
        });
        $(".timelist option").each(function(index, el) {
            var oid = $(this).attr('value');
            if(oid == gid){
              $(this).attr('selected', 'selected');
            }
        });
      });

      
      


      $(".citylist").change(function(event) {
            var changeurl = changeURLPar(destiny, 'cityid', $(this).val())
            window.location.href = changeurl
          });
      $(".timelist").change(function(event) {
          window.location.href = changeURLPar('/Channels/Competetion/internationalEvents.aspx', 'id', $(this).val())
        });
function GetQueryString(name) {
  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
  var r = window.location.search.substr(1).match(reg);
  if (r != null) return unescape(r[2]); return null;
  }
function changeURLPar(destiny, par, par_value){
    var pattern = par+'=([^&]*)';
    var replaceText = par+'='+par_value;
    if (destiny.match(pattern)){
        var tmp = '/'+par+'=[^&]*/';

        

        tmp = destiny.replace(eval(tmp), replaceText);

        return (tmp);
    }else{
        if (destiny.match('[\?]')){
            return destiny+'&'+ replaceText;
        }else{
            return destiny+'?'+replaceText;
        }
    }
    return destiny+'\n'+par+'\n'+par_value;
}
    </script>
</body>
</html>
